import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_podcast_data_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_podcast_data_entitie.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_podcast_entity.dart';

class OtherUserPodcastModel extends OtherUserPodcastEntity {
  const OtherUserPodcastModel(
      {required super.results, required super.otherUserPodcastDataEntitie});

  factory OtherUserPodcastModel.fromJson(Map<String, dynamic> json) {
    return OtherUserPodcastModel(
        results: json['results'],
        otherUserPodcastDataEntitie: (json['data'] as List)
            .map((e) => OtherUserPodcastDataModel.fromJson(e))
            .toList());
  }

  @override
  OtherUserPodcastEntity copyWith(
      {int? results,
      List<OtherUserPodcastDataEntity>? otherUserPodcastDataEntitie}) {
    return OtherUserPodcastModel(
      results: results ?? this.results,
      otherUserPodcastDataEntitie:
          otherUserPodcastDataEntitie ?? this.otherUserPodcastDataEntitie,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'results': results,
      'data': otherUserPodcastDataEntitie.map((e) => e.toJson()).toList()
    };
  }

  @override
  List<Object?> get props => [
        results,
        otherUserPodcastDataEntitie,
      ];
}
