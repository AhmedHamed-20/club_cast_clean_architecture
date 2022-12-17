import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/upload_podcast_entitie.dart';

class PodcastUploadModel extends PodcastUploadEntitie {
  const PodcastUploadModel(super.name, super.category, super.publicId);

  factory PodcastUploadModel.fromJson(Map<String, dynamic> json) {
    return PodcastUploadModel(
        json['name'], json['category'], json['public_id']);
  }
}
