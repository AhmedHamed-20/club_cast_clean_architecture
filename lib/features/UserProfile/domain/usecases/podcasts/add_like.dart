// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';

class LikeAddMyPodcastsUsecast
    extends BaseUsecase<void, LikeAddMyPodcastsParams> {
  final BaseUserInfoRepository userInfoRepository;

  LikeAddMyPodcastsUsecast(this.userInfoRepository);
  @override
  Future<Either<Failure, void>> call(LikeAddMyPodcastsParams params) async {
    return await userInfoRepository.addLikeToPodcast(params);
  }
}

class LikeAddMyPodcastsParams extends Equatable {
  final String accessToken;
  final String podcastId;
  const LikeAddMyPodcastsParams({
    required this.accessToken,
    required this.podcastId,
  });

  @override
  List<Object?> get props => [accessToken, podcastId];
}
