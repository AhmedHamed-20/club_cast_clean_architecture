import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_event_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/other_users_basic_info_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/updated_user_data_info.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/create_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/update_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/add_like.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/get_my_podcasts.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/remove_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/create_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/get_followers.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/get_more_followers.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_password.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_info.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/podcast_upload_model.dart';
import '../entities/signature_entitie.dart';
import '../usecases/events/get_my_events.dart';
import '../usecases/events/remove_event.dart';
import '../usecases/podcasts/remove_like.dart';
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
  Future<Either<Failure, void>> createEvent(EventCreateParams params);

  Future<Either<Failure, List<MyEventEntitie>>> getMyEvents(
      MyEventsParams params);
  Future<Either<Failure, void>> addLikeToPodcast(
      LikeAddMyPodcastsParams params);

  Future<Either<Failure, void>> removeLike(LikeRemoveMyPodcastsParams params);
  Future<Either<Failure, OtherUsersDataEntitie>> getFollowers(
      FollowersFollowingParams params);
  Future<Either<Failure, OtherUsersDataEntitie>> getFollowing(
      FollowersFollowingParams params);

  Future<Either<Failure, OtherUsersDataEntitie>> getMoreFollowing(
      MoreFollowersFollowingGetParams params);
  Future<Either<Failure, OtherUsersDataEntitie>> getMoreFollowers(
      MoreFollowersFollowingGetParams params);

  Future<Either<Failure, void>> removePodcast(PodcastRemoveParams params);
  Future<Either<Failure, void>> updateEvent(EventUpdateUsecaseParams params);
  Future<Either<Failure, void>> removeEvent(EventRemoveUsecaseParams params);
}
