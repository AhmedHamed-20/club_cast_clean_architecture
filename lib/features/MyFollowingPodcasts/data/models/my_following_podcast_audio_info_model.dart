import '../../../../core/constants/base_podcast_entitie/base_podcast_audio_info.dart';

class PodcastAudioInfoModel extends PodcastAudioInoEntitie {
  const PodcastAudioInfoModel(super.podcastDuration, super.podcastUrl);

  factory PodcastAudioInfoModel.fromJson(Map<String, dynamic> json) {
    return PodcastAudioInfoModel(json['duration'], json['url']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'duration': podcastDuration, 'url': podcastUrl};
  }

  @override
  List<Object?> get props => [podcastDuration, podcastUrl];
}
