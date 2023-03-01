import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_more_my_following_podcasts.dart';
import 'package:equatable/equatable.dart';

part 'podcast_event.dart';
part 'podcast_state.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  PodcastBloc(this.followingPodcastUsecase, this.moreMyFollowingPodcastsUsecase)
      : super(const PodcastState()) {
    on<GetMyFollowingPodcastsEvent>(_getMyFollowingPodcast);
    on<MoreMyFollowingPodcastsGetEvent>(_getMoreMyFollowingPodcasts);
  }
  final FollowingPodcastUsecase followingPodcastUsecase;
  final MoreMyFollowingPodcastsUsecase moreMyFollowingPodcastsUsecase;

  FutureOr<void> _getMyFollowingPodcast(
      GetMyFollowingPodcastsEvent event, Emitter<PodcastState> emit) async {
    final result = await followingPodcastUsecase(
        MyFollowingPodcastParams(event.accessToken));

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
    final result = await moreMyFollowingPodcastsUsecase(
      MoreMyFollowingPodcastParams(
        accessToken: event.accessToken,
        page: event.page,
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
        MyFollowingPodcastEntitie myFollowingPodcastsModel;
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
        MyFollowingPodcastEntitie myFollowingPodcastsModel =
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
}
