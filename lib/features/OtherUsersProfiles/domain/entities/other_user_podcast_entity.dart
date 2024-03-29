// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'other_user_podcast_data_entitie.dart';

abstract class OtherUserPodcastEntity extends Equatable {
  final int results;
  final List<OtherUserPodcastDataEntity> otherUserPodcastDataEntitie;
  const OtherUserPodcastEntity({
    required this.results,
    required this.otherUserPodcastDataEntitie,
  });

  OtherUserPodcastEntity copyWith({
    int? results,
    List<OtherUserPodcastDataEntity>? otherUserPodcastDataEntitie,
  });

  Map<String, dynamic> toJson();
}
