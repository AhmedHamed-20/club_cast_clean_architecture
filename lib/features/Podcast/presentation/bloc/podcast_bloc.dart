import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:club_cast_clean_architecture/core/utl/utls.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/entities/podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/entities/podcast_likes_users_entitie.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/get_following_podcast.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_podcast_likes_users.dart';
import '../../domain/usecases/remove_like_by_podcast_id.dart';

part 'podcast_event.dart';
part 'podcast_state.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  PodcastBloc(this.addLikeUsecase, this.followingPodcastUsecase,
      this.podcastLikesUsersUsecase, this.removeLikeUsecase)
      : super(const PodcastState()) {
    on<GetMyFollowingPodcastsEvent>(_getMyFollowingPodcast);
    on<AddLikeToPodcastEvent>(_addLikeToPodcast);
    on<GetPodcastLikesUsersEvent>(_getPodcastLikesUsers);
    on<RemovePodcastLikeEvent>(_removePodcastLike);
  }
  final FollowingPodcastUsecase followingPodcastUsecase;
  final PodcastLikesUsersUsecase podcastLikesUsersUsecase;
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
      )),
      (r) => emit(
        state.copyWith(
          errorMessage: '',
        ),
      ),
    );
  }

  FutureOr<void> _getPodcastLikesUsers(
      GetPodcastLikesUsersEvent event, Emitter<PodcastState> emit) async {
    final result = await podcastLikesUsersUsecase(
        PodcastLikesUsersparams(event.accessToken, event.podcastId));
    result.fold(
        (l) => emit(state.copyWith(
            errorMessage: l.message,
            myFollowingPodcastsUsersLikesRequestStatus:
                MyFollowingPodcastsUsersLikesRequestStatus.error)),
        (r) => emit(state.copyWith(
            errorMessage: '',
            podcastLikesUsersEntitie: r,
            myFollowingPodcastsUsersLikesRequestStatus:
                MyFollowingPodcastsUsersLikesRequestStatus.success)));
  }

  FutureOr<void> _removePodcastLike(
      RemovePodcastLikeEvent event, Emitter<PodcastState> emit) async {
    final result = await removeLikeUsecase(LikeRemoveByPodcastIdParams(
        accessToken: event.accessToken, podcastId: event.podcastId));

    result.fold(
      (l) => emit(state.copyWith(
        errorMessage: l.message,
      )),
      (r) => emit(
        state.copyWith(
          errorMessage: '',
        ),
      ),
    );
  }
}
