import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/podcast_upload_model.dart';

class PodcastUploadUsecase
    extends BaseUsecase<PodcastUploadModel, PodcastUploadParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  PodcastUploadUsecase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, PodcastUploadModel>> call(
      PodcastUploadParams params) async {
    return await baseUserInfoRepository.uploadPodcast(params);
  }
}

class PodcastUploadParams extends Equatable {
  final String filePath;
  final String accessToken;
  final String timestamp;
  final String cloudName;
  final String apiKey;
  final String signature;

  const PodcastUploadParams(
      {required this.accessToken,
      required this.timestamp,
      required this.filePath,
      required this.cloudName,
      required this.apiKey,
      required this.signature});

  @override
  List<Object?> get props => [
        accessToken,
        timestamp,
        signature,
        apiKey,
        cloudName,
        filePath,
        accessToken,
      ];
}
