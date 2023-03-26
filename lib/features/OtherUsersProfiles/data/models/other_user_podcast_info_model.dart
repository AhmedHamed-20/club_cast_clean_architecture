import '../../../../core/constants/base_podcast_entitie/base_podcast_audio_info.dart';

class OtherUserPodcastAudioInfoModel extends PodcastAudioInoEntitie {
  const OtherUserPodcastAudioInfoModel(super.podcastDuration, super.podcastUrl);

  factory OtherUserPodcastAudioInfoModel.fromJson(Map<String, dynamic> json) {
    return OtherUserPodcastAudioInfoModel(json['duration'], json['url']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'duration': podcastDuration, 'url': podcastUrl};
  }

  @override
  List<Object?> get props => [podcastDuration, podcastUrl];
}
