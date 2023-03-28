import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entity.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/podcast_information_entity.dart';

part 'podcast_event.dart';
part 'podcast_state.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  PodcastBloc(
    this.followingPodcastUsecase,
  ) : super(const PodcastState()) {
    on<GetMyFollowingPodcastsEvent>(_getMyFollowingPodcast);
    on<MoreMyFollowingPodcastsGetEvent>(_getMoreMyFollowingPodcasts);
    on<UpdatePodcastLikesCountEvent>(_updatePodcastLikesCount);
  }
  final MyFollowingPodcastGetUsecase followingPodcastUsecase;

  FutureOr<void> _getMyFollowingPodcast(
      GetMyFollowingPodcastsEvent event, Emitter<PodcastState> emit) async {
    final result = await followingPodcastUsecase(
        MyFollowingPodcastParams(event.accessToken, 1));

    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            statusCode: l.statusCode,
            myFollowingPodcastsRequestStatus:
                MyFollowingPodcastsRequestStatus.error)),
        (r) => emit(state.copyWith(
            errorMessage: '',
            statusCode: 0,
            myFollowingPodcasts: r,
            isEndOfData: r.results < 10 ? true : false,
            myFollowingPodcastsRequestStatus:
                MyFollowingPodcastsRequestStatus.success)));
  }

  FutureOr<void> _getMoreMyFollowingPodcasts(
      MoreMyFollowingPodcastsGetEvent event, Emitter<PodcastState> emit) async {
    final result = await followingPodcastUsecase(
      MyFollowingPodcastParams(
        event.accessToken,
        event.page,
      ),
    );
    result.fold(
        (l) => emit(state.copyWith(
              statusCode: l.statusCode,
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
        MyFollowingPodcastEntity myFollowingPodcastsModel;
        myFollowingPodcastsModel = state.myFollowingPodcasts!;

        myFollowingPodcastsModel.podcastInformationEntitie
            .addAll(r.podcastInformationEntitie);

        emit(state.copyWith(
          errorMessage: '',
          statusCode: 0,
          myFollowingPodcasts: myFollowingPodcastsModel.copyWith(),
          isEndOfData: false,
          moreMyFollowingPodcastsRequestStatus:
              MyFollowingPodcastsRequestStatus.success,
        ));
      } else {
        MyFollowingPodcastEntity myFollowingPodcastsModel =
            state.myFollowingPodcasts!;
        myFollowingPodcastsModel.podcastInformationEntitie
            .addAll(r.podcastInformationEntitie);
        emit(state.copyWith(
          errorMessage: '',
          myFollowingPodcasts: myFollowingPodcastsModel.copyWith(),
          isEndOfData: true,
          moreMyFollowingPodcastsRequestStatus:
              MyFollowingPodcastsRequestStatus.success,
        ));
      }
    });
  }

  FutureOr<void> _updatePodcastLikesCount(
      UpdatePodcastLikesCountEvent event, Emitter<PodcastState> emit) {
    List<PodcastInformationEntity> myFollowingPodcastsModel =
        state.myFollowingPodcasts!.podcastInformationEntitie;

    for (int i = 0;
        i < state.myFollowingPodcasts!.podcastInformationEntitie.length;
        i++) {
      if (state.myFollowingPodcasts!.podcastInformationEntitie[i].podcastId ==
          event.podcastId) {
        if (event.isLiked) {
          myFollowingPodcastsModel[i] = myFollowingPodcastsModel[i].copyWith(
              podcastLikesCount:
                  myFollowingPodcastsModel[i].podcastLikesCount - 1,
              isLiked: false);
        } else {
          myFollowingPodcastsModel[i] = myFollowingPodcastsModel[i].copyWith(
              podcastLikesCount:
                  myFollowingPodcastsModel[i].podcastLikesCount + 1,
              isLiked: true);
        }
      }
    }
    emit(
      state.copyWith(
        myFollowingPodcasts: MyFollowingPodcastEntity(
                podcastInformationEntitie: myFollowingPodcastsModel,
                results: state.myFollowingPodcasts!.results)
            .copyWith(),
      ),
    );
  }
}
