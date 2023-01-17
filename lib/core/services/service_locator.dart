import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/data/datasource/remote_data_source_common_playing_podcast.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/data/repository/common_playing_podcast_repository_impl.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/repository/base_commo_podcast_repository.dart';
import 'package:club_cast_clean_architecture/core/layout/data/datasources/layout_local_data_source_impl.dart';
import 'package:club_cast_clean_architecture/core/layout/data/datasources/layout_remote_data_source_impl.dart';
import 'package:club_cast_clean_architecture/core/layout/data/repositories/layout_repository_impl.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/repositories/base_layout_repository.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_active_user_data.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_cached_access_token.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_categories.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_my_following_events.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/remove_access_token.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/update_cached_access_token.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/datasources/auth_local_data_source.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/repositories/auth_repository.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/repositories/auth_repository.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/cache_access_token.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/forget_password.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/sign_up.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/repositories/podcast_repository.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/usecases/download_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/get_more_my_following_podcasts.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/domain/usecases/get_podcast_likes_users.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/domain/usecases/remove_like_by_podcast_id.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/presentation/bloc/podcast_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/datasources/remote_user_info_data_source_impl.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/repositories/user_info_repository_impl.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/create_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/get_my_events.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/remove_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/update_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/add_like.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/get_my_podcasts.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/remove_like.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/remove_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/create_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/generate_signature.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/upload_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/get_followers.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/get_following.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_password.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_image.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_info.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/Auth/domain/usecases/login.dart';
import '../../features/MyFollowingPodcasts/data/datasources/pdocast_remote_data_source.dart';
import '../../features/MyFollowingPodcasts/data/repositories/podcast_repository.dart';
import '../../features/UserProfile/domain/usecases/user_information/get_more_followers.dart';
import '../../features/UserProfile/domain/usecases/user_information/get_more_following.dart';
import '../common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';

final servicelocator = GetIt.instance;

class ServiceLocator {
  static void init() {
    ///bloc
    servicelocator.registerFactory<AuthBloc>(() => AuthBloc(servicelocator(),
        servicelocator(), servicelocator(), servicelocator()));
    servicelocator.registerFactory<PodcastBloc>(() => PodcastBloc(
          servicelocator(),
          servicelocator(),
          servicelocator(),
          servicelocator(),
        ));

    servicelocator.registerFactory<LayoutBloc>(() => LayoutBloc(
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator()));
    servicelocator.registerFactory<CommonPlayingPodcastBlocBloc>(
        () => CommonPlayingPodcastBlocBloc(servicelocator(), servicelocator()));
    servicelocator.registerFactory<UserProfileBloc>(() => UserProfileBloc(
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator()));

    ///usecase
    servicelocator.registerLazySingleton<SignUpUsecase>(
        () => SignUpUsecase(servicelocator()));
    servicelocator.registerLazySingleton<LoginUsecase>(
        () => LoginUsecase(servicelocator()));
    servicelocator.registerLazySingleton<ForgetPasswordUsecase>(
        () => ForgetPasswordUsecase(servicelocator()));

    servicelocator.registerLazySingleton<FollowingPodcastUsecase>(
        () => FollowingPodcastUsecase(servicelocator()));
    servicelocator.registerLazySingleton<PodcastLikesUsersUsecase>(
        () => PodcastLikesUsersUsecase(servicelocator()));
    servicelocator.registerLazySingleton<LikeAddByIdUsecase>(
        () => LikeAddByIdUsecase(servicelocator()));
    servicelocator.registerLazySingleton<LikeRemoveByPodcastIdUsecase>(
        () => LikeRemoveByPodcastIdUsecase(servicelocator()));
    servicelocator.registerLazySingleton<ActiveUserDataGetUseCase>(
        () => ActiveUserDataGetUseCase(servicelocator()));
    servicelocator.registerLazySingleton<UserDataUpdateUseCase>(
        () => UserDataUpdateUseCase(servicelocator()));
    servicelocator.registerLazySingleton<SignatureGenerateUsecase>(
        () => SignatureGenerateUsecase(servicelocator()));
    servicelocator.registerLazySingleton<PodcastUploadUsecase>(
        () => PodcastUploadUsecase(servicelocator()));
    servicelocator.registerLazySingleton<PodcastCreateUseCase>(
        () => PodcastCreateUseCase(servicelocator()));
    servicelocator.registerLazySingleton<MyPodcastsGetUseCase>(
        () => MyPodcastsGetUseCase(servicelocator()));
    servicelocator.registerLazySingleton<PasswordUpdateUseCase>(
        () => PasswordUpdateUseCase(servicelocator()));
    servicelocator.registerFactory<EventCreateUseCase>(
        () => EventCreateUseCase(servicelocator()));
    servicelocator.registerFactory<MyEventsGetUsecase>(
        () => MyEventsGetUsecase(servicelocator()));
    servicelocator.registerFactory<AccessTokenCacheUsecase>(
        () => AccessTokenCacheUsecase(servicelocator()));
    servicelocator.registerFactory<CachedAccessTokenGetUsecase>(
        () => CachedAccessTokenGetUsecase(servicelocator()));
    servicelocator.registerFactory<MyFollowingEventsUsecase>(
        () => MyFollowingEventsUsecase(servicelocator()));
    servicelocator.registerFactory<MoreMyFollowingPodcastsUsecase>(
        () => MoreMyFollowingPodcastsUsecase(servicelocator()));
    servicelocator.registerFactory<PodcastDownloadUsecase>(
        () => PodcastDownloadUsecase(servicelocator()));
    servicelocator.registerFactory<LikeAddMyPodcastsUsecast>(
        () => LikeAddMyPodcastsUsecast(servicelocator()));
    servicelocator.registerFactory<LikeRemoveMyPodcastsUsecast>(
        () => LikeRemoveMyPodcastsUsecast(servicelocator()));

    servicelocator.registerFactory<MyFollowingGetUseCase>(
        () => MyFollowingGetUseCase(servicelocator()));
    servicelocator.registerFactory<MyFollowersGetUseCase>(
        () => MyFollowersGetUseCase(servicelocator()));
    servicelocator.registerFactory<MoreFollowersGetUsecase>(
        () => MoreFollowersGetUsecase(servicelocator()));
    servicelocator.registerFactory<MoreFollowingGetUsecase>(
        () => MoreFollowingGetUsecase(servicelocator()));
    servicelocator.registerFactory<PodcastRemoveUsecase>(
        () => PodcastRemoveUsecase(servicelocator()));

    servicelocator.registerFactory<EventRemoveUsecase>(
        () => EventRemoveUsecase(servicelocator()));
    servicelocator.registerFactory<EventUpdateUsecase>(
        () => EventUpdateUsecase(servicelocator()));
    servicelocator.registerFactory<CategoriesGetUsecase>(
        () => CategoriesGetUsecase(servicelocator()));
    servicelocator.registerFactory<UpdateUserImageUsecase>(
        () => UpdateUserImageUsecase(servicelocator()));
    servicelocator.registerFactory<CachedAccessTokenUpdateUsecase>(
        () => CachedAccessTokenUpdateUsecase(servicelocator()));
    servicelocator.registerFactory<AccessTokenRemoveUsecase>(
        () => AccessTokenRemoveUsecase(servicelocator()));

    ///repository
    servicelocator.registerLazySingleton<BaseAuthRepository>(
        () => AuthRepositoryImple(servicelocator(), servicelocator()));

    servicelocator.registerLazySingleton<BasePodcastRepository>(
        () => PodcastRepositoryImple(servicelocator()));
    servicelocator.registerLazySingleton<BaseLayoutRepository>(
        () => LayoutRepositoryImpl(servicelocator(), servicelocator()));
    servicelocator.registerLazySingleton<BaseUserInfoRepository>(
        () => UserInfoRepositoryImpl(servicelocator()));
    servicelocator.registerLazySingleton<BaseCommonPodcastRepository>(
        () => CommonPlayingPodcastRepositoryImpl(servicelocator()));

    ///datasource
    servicelocator.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl());
    servicelocator.registerLazySingleton<BaseAuthLocalDataSource>(
        () => AuthLocalDataSourceImpl());
    servicelocator.registerLazySingleton<BasePodcastRemoteDataSource>(
        () => PodcastRemoteDataSourceImpl());
    servicelocator.registerLazySingleton<BaseLayoutRemoteDataSource>(
        () => LayoutRemoteDataSourceImpl());
    servicelocator.registerLazySingleton<BaseLayoutLocalDataSource>(
        () => LayoutLocalDataSourceImpl());
    servicelocator.registerLazySingleton<BaseUserInfoRemoteDataSource>(
        () => RemoteUserInfoDataSourceImpl());
    servicelocator.registerLazySingleton<BaseCommonPlayingPodcastDataSource>(
        () => RemoteCommonPlayingPodcastDataSource());
  }
}
