// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'other_user_podcast_data_entitie.dart';

class OtherUserPodcastEntitie extends Equatable {
  final int results;
  final List<OtherUserPodcastDataEntitie> otherUserPodcastDataEntitie;
  const OtherUserPodcastEntitie({
    required this.results,
    required this.otherUserPodcastDataEntitie,
  });

  OtherUserPodcastEntitie copyWith({
    int? results,
    List<OtherUserPodcastDataEntitie>? otherUserPodcastDataEntitie,
  }) {
    return OtherUserPodcastEntitie(
      results: results ?? this.results,
      otherUserPodcastDataEntitie:
          otherUserPodcastDataEntitie ?? this.otherUserPodcastDataEntitie,
    );
  }

  @override
  List<Object?> get props => [results, otherUserPodcastDataEntitie];
}
