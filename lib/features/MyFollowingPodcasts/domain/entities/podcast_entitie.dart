// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_information_entitie.dart';

class MyFollowingPodcastEntitie extends Equatable {
  final int results;
  final List<PodcastInformationEntitie> podcastInformationEntitie;
  const MyFollowingPodcastEntitie({
    required this.results,
    required this.podcastInformationEntitie,
  });

  MyFollowingPodcastEntitie copyWith({
    int? results,
    List<PodcastInformationEntitie>? podcastInformationEntitie,
  }) {
    return MyFollowingPodcastEntitie(
      results: results ?? this.results,
      podcastInformationEntitie:
          podcastInformationEntitie ?? this.podcastInformationEntitie,
    );
  }

  @override
  List<Object?> get props => [
        podcastInformationEntitie,
        results,
      ];
}
