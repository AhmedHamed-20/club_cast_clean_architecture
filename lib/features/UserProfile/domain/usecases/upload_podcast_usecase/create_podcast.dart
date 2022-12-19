import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class PodcastCreateUseCase extends BaseUsecase<void, PodcastCreateParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  PodcastCreateUseCase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, void>> call(PodcastCreateParams params) async {
    return await baseUserInfoRepository.createPodcast(params);
  }
}

class PodcastCreateParams extends Equatable {
  final String accessToken;
  final String podcastName;
  final String category;
  final String publicId;

  const PodcastCreateParams(
      {required this.accessToken,
      required this.podcastName,
      required this.category,
      required this.publicId});

  @override
  List<Object?> get props => [
        accessToken,
        podcastName,
        category,
        publicId,
      ];
}
