import 'package:equatable/equatable.dart';

class PodcastAudioInoEntitie extends Equatable {
  final double podcastDuration;
  final String podcastUrl;

  const PodcastAudioInoEntitie(this.podcastDuration, this.podcastUrl);

  @override
  List<Object?> get props => [podcastDuration, podcastUrl];
}
