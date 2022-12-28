// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';

class LikeRemoveMyPodcastsUsecast
    extends BaseUsecase<void, LikeRemoveMyPodcastsParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  LikeRemoveMyPodcastsUsecast(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, void>> call(LikeRemoveMyPodcastsParams params) async {
    return await baseUserInfoRepository.removeLike(params);
  }
}

class LikeRemoveMyPodcastsParams extends Equatable {
  final String accessToken;
  final String podcastId;
  const LikeRemoveMyPodcastsParams({
    required this.accessToken,
    required this.podcastId,
  });

  @override
  List<Object?> get props => [accessToken, podcastId];
}
