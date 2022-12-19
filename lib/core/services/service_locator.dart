import 'package:club_cast_clean_architecture/core/layout/data/datasources/layout_remote_data_source_impl.dart';
import 'package:club_cast_clean_architecture/core/layout/data/repositories/layout_repository_impl.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/repositories/base_layout_repository.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_active_user_data.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/repositories/auth_repository.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/repositories/auth_repository.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/forget_password.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/sign_up.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/repositories/podcast_repository.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/add_like.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/get_following_podcast.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/get_podcast_likes_users.dart';
import 'package:club_cast_clean_architecture/features/Podcast/domain/usecases/remove_like_by_podcast_id.dart';
import 'package:club_cast_clean_architecture/features/Podcast/presentation/bloc/podcast_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/datasources/remote_user_info_data_source_impl.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/data/repositories/user_info_repository_impl.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/repositories/base_user_info_repository.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/create_event.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/events/get_my_events.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/podcasts/get_my_podcasts.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/create_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/generate_signature.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/upload_podcast_usecase/upload_podcast.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_password.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/domain/usecases/user_information/update_user_info.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/Auth/domain/usecases/login.dart';
import '../../features/Podcast/data/datasources/pdocast_remote_data_source.dart';
import '../../features/Podcast/data/repositories/podcast_repository.dart';

final servicelocator = GetIt.instance;

class ServiceLocator {
  void init() {
    ///bloc
    servicelocator.registerFactory<AuthBloc>(
        () => AuthBloc(servicelocator(), servicelocator(), servicelocator()));
    servicelocator.registerFactory<PodcastBloc>(() => PodcastBloc(
        servicelocator(),
        servicelocator(),
        servicelocator(),
        servicelocator()));

    servicelocator
        .registerFactory<LayoutBloc>(() => LayoutBloc(servicelocator()));

    servicelocator.registerFactory<UserprofileBloc>(() => UserprofileBloc(
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

    ///repository
    servicelocator.registerLazySingleton<BaseAuthRepository>(
        () => AuthRepositoryImple(servicelocator()));
    servicelocator.registerLazySingleton<BasePodcastRepository>(
        () => PodcastRepositoryImple(servicelocator()));
    servicelocator.registerLazySingleton<BaseLayoutRepository>(
        () => LayoutRepositoryImpl(servicelocator()));
    servicelocator.registerLazySingleton<BaseUserInfoRepository>(
        () => UserInfoRepositoryImpl(servicelocator()));

    ///datasource
    servicelocator.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl());
    servicelocator.registerLazySingleton<BasePodcastRemoteDataSource>(
        () => PodcastRemoteDataSourceImpl());
    servicelocator.registerLazySingleton<BaseLayoutRemoteDataSource>(
        () => LayoutRemoteDataSourceImpl());
    servicelocator.registerLazySingleton<BaseUserInfoRemoteDataSource>(
        () => RemoteUserInfoDataSourceImpl());
  }
}
