import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/upload_podcast_entitie.dart';

class PodcastUploadModel extends PodcastUploadEntitie {
  const PodcastUploadModel(super.name, super.publicId);

  factory PodcastUploadModel.fromJson(Map<String, dynamic> json) {
    return PodcastUploadModel(json['original_filename'], json['public_id']);
  }
}
