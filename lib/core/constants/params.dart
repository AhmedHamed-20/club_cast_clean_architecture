import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/presentation/bloc/podcast_bloc.dart';
import 'package:equatable/equatable.dart';

class LikesUsersScreenParams extends Equatable {
  final String podcastId;
  final PodcastBloc podcastBloc;

  const LikesUsersScreenParams(
      {required this.podcastId, required this.podcastBloc});

  @override
  List<Object?> get props => [podcastBloc, podcastId];
}
