import 'dart:async';

import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/repository/base_commo_podcast_repository.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class PodcastDownloadUsecase extends BaseUsecase<void, PodcastDownloadParams> {
  final BaseCommonPodcastRepository baseCommonPodcastRepository;

  PodcastDownloadUsecase(this.baseCommonPodcastRepository);
  @override
  Future<Either<Failure, void>> call(PodcastDownloadParams params) async {
    return await baseCommonPodcastRepository.downloadPodcast(params);
  }
}

class PodcastDownloadParams extends Equatable {
  final String podcastUrl;
  final String savedPath;
  final StreamController receivedData;
  const PodcastDownloadParams(
      {required this.podcastUrl,
      required this.savedPath,
      required this.receivedData});

  @override
  List<Object?> get props => [podcastUrl, savedPath, receivedData];
}
