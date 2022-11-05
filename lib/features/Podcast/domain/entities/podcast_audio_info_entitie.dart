import 'package:equatable/equatable.dart';

class PodcastAudioInoEntitie extends Equatable {
  final int podcastDuration;
  final String podcastUrl;

  const PodcastAudioInoEntitie(this.podcastDuration, this.podcastUrl);

  @override
  List<Object?> get props => [podcastDuration, podcastUrl];
}
