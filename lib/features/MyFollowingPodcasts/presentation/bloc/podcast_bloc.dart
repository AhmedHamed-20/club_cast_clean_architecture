import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_more_my_following_podcasts.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/remove_like_by_podcast_id.dart';

part 'podcast_event.dart';
part 'podcast_state.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  PodcastBloc(this.addLikeUsecase, this.followingPodcastUsecase,
      this.removeLikeUsecase, this.moreMyFollowingPodcastsUsecase)
      : super(const PodcastState()) {
    on<GetMyFollowingPodcastsEvent>(_getMyFollowingPodcast);
    on<AddLikeToPodcastEvent>(_addLikeToPodcast);
    on<RemovePodcastLikeEvent>(_removePodcastLikeAndGetNewData);
    on<MoreMyFollowingPodcastsGetEvent>(_getMoreMyFollowingPodcasts);
  }
  final FollowingPodcastUsecase followingPodcastUsecase;
  final MoreMyFollowingPodcastsUsecase moreMyFollowingPodcastsUsecase;

  final LikeAddByIdUsecase addLikeUsecase;
  final LikeRemoveByPodcastIdUsecase removeLikeUsecase;
  FutureOr<void> _getMyFollowingPodcast(
      GetMyFollowingPodcastsEvent event, Emitter<PodcastState> emit) async {
    final result = await followingPodcastUsecase(
        MyFollowingPodcastParams(event.accessToken));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            myFollowingPodcastsRequestStatus:
                MyFollowingPodcastsRequestStatus.error)),
        (r) => emit(state.copyWith(
            errorMessage: '',
            myFollowingPodcasts: r,
            myFollowingPodcastsRequestStatus:
                MyFollowingPodcastsRequestStatus.success)));
  }

  FutureOr<void> _addLikeToPodcast(
      AddLikeToPodcastEvent event, Emitter<PodcastState> emit) async {
    final result = await addLikeUsecase(LikeAddParams(
      event.accessToken,
      event.podcastId,
    ));
    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
            )), (r) {
      emit(
        state.copyWith(
          errorMessage: '',
        ),
      );
      add(
        GetMyFollowingPodcastsEvent(
          accessToken: event.accessToken,
        ),
      );
    });
  }

  FutureOr<void> _removePodcastLikeAndGetNewData(
      RemovePodcastLikeEvent event, Emitter<PodcastState> emit) async {
    final result = await removeLikeUsecase(LikeRemoveByPodcastIdParams(
        accessToken: event.accessToken, podcastId: event.podcastId));

    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
            )), (r) {
      emit(
        state.copyWith(
          errorMessage: '',
        ),
      );
      add(
        GetMyFollowingPodcastsEvent(
          accessToken: event.accessToken,
        ),
      );
    });
  }

  FutureOr<void> _getMoreMyFollowingPodcasts(
      MoreMyFollowingPodcastsGetEvent event, Emitter<PodcastState> emit) async {
    final result = await moreMyFollowingPodcastsUsecase(
      MoreMyFollowingPodcastParams(
        accessToken: event.accessToken,
        page: event.page,
      ),
    );
    result.fold(
        (l) => emit(state.copyWith(
              errorMessage: l.message,
              moreMyFollowingPodcastsRequestStatus:
                  MyFollowingPodcastsRequestStatus.error,
            )), (r) {
      if (r.results == 0) {
        emit(state.copyWith(
            isEndOfData: true,
            moreMyFollowingPodcastsRequestStatus:
                MyFollowingPodcastsRequestStatus.success));
      } else if (r.results == 10) {
        PodcastEntitie myFollowingPodcastsModel;
        myFollowingPodcastsModel = state.myFollowingPodcasts!;

        myFollowingPodcastsModel.podcastInformationEntitie
            .addAll(r.podcastInformationEntitie);

        emit(state.copyWith(
          errorMessage: '',
          myFollowingPodcasts: myFollowingPodcastsModel,
          isEndOfData: false,
          moreMyFollowingPodcastsRequestStatus:
              MyFollowingPodcastsRequestStatus.success,
        ));
      } else {
        PodcastEntitie myFollowingPodcastsModel = state.myFollowingPodcasts!;
        myFollowingPodcastsModel.podcastInformationEntitie
            .addAll(r.podcastInformationEntitie);
        emit(state.copyWith(
          errorMessage: '',
          myFollowingPodcasts: myFollowingPodcastsModel,
          isEndOfData: true,
          moreMyFollowingPodcastsRequestStatus:
              MyFollowingPodcastsRequestStatus.success,
        ));
      }
    });
  }
}
