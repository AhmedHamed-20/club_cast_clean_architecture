import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_entitie.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/base_user_info_repository.dart';

class MyPodcastsGetUseCase
    extends BaseUsecase<List<MyPodcastEntite>, MyPodcastGetParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  MyPodcastsGetUseCase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, List<MyPodcastEntite>>> call(
      MyPodcastGetParams params) async {
    return await baseUserInfoRepository.getMyPodcasts(params);
  }
}

class MyPodcastGetParams extends Equatable {
  final String accessToken;

  const MyPodcastGetParams(this.accessToken);

  @override
  List<Object?> get props => [accessToken];
}
