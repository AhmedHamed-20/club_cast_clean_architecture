import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class PodcastRemoveUsecase extends BaseUsecase<void, PodcastRemoveParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  PodcastRemoveUsecase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, void>> call(PodcastRemoveParams params) async {
    return await baseUserInfoRepository.removePodcast(params);
  }
}

class PodcastRemoveParams extends Equatable {
  final String accessToken;
  final String podcastId;

  const PodcastRemoveParams(
      {required this.accessToken, required this.podcastId});

  @override
  List<Object?> get props => [accessToken, podcastId];
}
