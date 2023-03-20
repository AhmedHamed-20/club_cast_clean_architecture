// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/entities/podcast_information_entity.dart';

class MyFollowingPodcastEntity extends Equatable {
  final int results;
  final List<PodcastInformationEntity> podcastInformationEntitie;
  const MyFollowingPodcastEntity({
    required this.results,
    required this.podcastInformationEntitie,
  });

  MyFollowingPodcastEntity copyWith({
    int? results,
    List<PodcastInformationEntity>? podcastInformationEntitie,
  }) {
    return MyFollowingPodcastEntity(
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
