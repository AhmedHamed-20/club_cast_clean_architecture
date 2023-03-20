import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_podcast_entity.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/repositories/base_other_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class OtherUserPodcastUsecase
    extends BaseUsecase<OtherUserPodcastEntity, OtherUserPodcastParams> {
  final BaseOtherUserProfilesRepository baseOtherUserProfilesRepository;

  OtherUserPodcastUsecase(this.baseOtherUserProfilesRepository);
  @override
  Future<Either<Failure, OtherUserPodcastEntity>> call(
      OtherUserPodcastParams params) async {
    return await baseOtherUserProfilesRepository.getOtherUserPodcast(params);
  }
}

class OtherUserPodcastParams extends Equatable {
  final String userId;
  final String accessToken;
  final int page;

  const OtherUserPodcastParams(
      {required this.userId, required this.accessToken, required this.page});

  @override
  List<Object?> get props => [userId, accessToken, page];
}
