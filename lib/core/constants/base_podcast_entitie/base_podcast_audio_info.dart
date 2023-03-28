import 'package:equatable/equatable.dart';

abstract class PodcastAudioInoEntitie extends Equatable {
  final double podcastDuration;
  final String podcastUrl;

  const PodcastAudioInoEntitie(this.podcastDuration, this.podcastUrl);

  Map<String, dynamic> toJson();
}
