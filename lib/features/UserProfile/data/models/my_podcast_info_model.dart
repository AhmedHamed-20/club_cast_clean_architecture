import '../../../../core/constants/base_podcast_entitie/base_podcast_audio_info.dart';

class MyPodcastAudioInfoModel extends PodcastAudioInoEntitie {
  const MyPodcastAudioInfoModel(super.podcastDuration, super.podcastUrl);

  factory MyPodcastAudioInfoModel.fromJson(Map<String, dynamic> json) {
    return MyPodcastAudioInfoModel(json['duration'], json['url']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'duration': podcastDuration,
      'url': podcastUrl,
    };
  }

  @override
  List<Object?> get props => [podcastDuration, podcastUrl];
}
