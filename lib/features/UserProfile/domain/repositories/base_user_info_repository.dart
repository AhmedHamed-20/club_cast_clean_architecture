import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/updated_user_data_info.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/get_my_podcasts.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/create_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_password.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_info.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/podcast_upload_model.dart';
import '../entities/signature_entitie.dart';
import '../usecases/upload_podcast_usecase/generate_signature.dart';
import '../usecases/upload_podcast_usecase/upload_podcast.dart';

abstract class BaseUserInfoRepository {
  Future<Either<Failure, List<MyPodcastEntite>>> getMyPodcasts(
      MyPodcastGetParams params);

  Future<Either<Failure, SignatureEntitie>> generateSignature(
      SignatureGenerateParams params);
  Future<Either<Failure, PodcastUploadModel>> uploadPodcast(
      PodcastUploadParams params);

  Future<Either<Failure, void>> createPodcast(PodcastCreateParams params);
  Future<Either<Failure, UpdatedUserDataInfoEntitie>> updateUserData(
      UserDataUpdateParams params);
  Future<Either<Failure, String>> updatePassword(PasswordUpdateParams params);
}
