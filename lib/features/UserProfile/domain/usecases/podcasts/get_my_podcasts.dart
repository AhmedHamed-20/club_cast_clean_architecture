import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../entities/my_podcast_entity.dart';
import '../../repositories/base_user_info_repository.dart';

class MyPodcastsGetUseCase
    extends BaseUsecase<MyPodcastEntity, MyPodcastGetParams> {
  final BaseUserInfoRepository baseUserInfoRepository;

  MyPodcastsGetUseCase(this.baseUserInfoRepository);
  @override
  Future<Either<Failure, MyPodcastEntity>> call(
      MyPodcastGetParams params) async {
    return await baseUserInfoRepository.getMyPodcasts(params);
  }
}

class MyPodcastGetParams extends Equatable {
  final String accessToken;
  final int page;
  const MyPodcastGetParams({required this.accessToken, required this.page});

  @override
  List<Object?> get props => [accessToken, page];
}
