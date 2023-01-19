import 'package:equatable/equatable.dart';

import 'other_user_podcast_data_entitie.dart';

class OtherUserPodcastEntitie extends Equatable {
  final int results;
  final List<OtherUserPodcastDataEntitie> otherUserPodcastDataEntitie;
  const OtherUserPodcastEntitie({
    required this.results,
    required this.otherUserPodcastDataEntitie,
  });

  @override
  List<Object?> get props => [results, otherUserPodcastDataEntitie];
}
