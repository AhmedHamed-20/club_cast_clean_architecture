import 'package:club_cast_clean_architecture/features/Podcast/domain/entities/podcast_audio_info_entitie.dart';

class PodcastAudioInfoModel extends PodcastAudioInoEntitie {
  const PodcastAudioInfoModel(super.podcastDuration, super.podcastUrl);

  factory PodcastAudioInfoModel.fromJson(Map<String, dynamic> json) {
    return PodcastAudioInfoModel(json['duration'], json['url']);
  }
}
