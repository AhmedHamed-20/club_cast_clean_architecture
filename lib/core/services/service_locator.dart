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

    ///repository
    servicelocator.registerLazySingleton<BaseAuthRepository>(
        () => AuthRepositoryImple(servicelocator()));
    servicelocator.registerLazySingleton<BasePodcastRepository>(
        () => PodcastRepositoryImple(servicelocator()));

    ///datasource
    servicelocator.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl());
    servicelocator.registerLazySingleton<BasePodcastRemoteDataSource>(
        () => PodcastRemoteDataSourceImpl());
  }
}
