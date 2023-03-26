import 'package:club_cast_clean_architecture/core/constants/base_podcast_entitie/base_podcast_audio_info.dart';

class PodcastAudioSearchInfoModel extends PodcastAudioInoEntitie {
  const PodcastAudioSearchInfoModel(super.podcastDuration, super.podcastUrl);

  factory PodcastAudioSearchInfoModel.fromJson(Map<String, dynamic> json) {
    return PodcastAudioSearchInfoModel(json['duration'], json['url']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'duration': podcastDuration, 'url': podcastUrl};
  }

  @override
  List<Object?> get props => [podcastDuration, podcastUrl];
}
