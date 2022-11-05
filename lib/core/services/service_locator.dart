import 'package:club_cast_clean_architecture/features/Auth/data/datasources/auth_remote_data_source.dart';
import 'package:club_cast_clean_architecture/features/Auth/data/repositories/auth_repository.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/repositories/auth_repository.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/forget_password.dart';
import 'package:club_cast_clean_architecture/features/Auth/domain/usecases/sign_up.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/Auth/domain/usecases/login.dart';

final servicelocator = GetIt.instance;

class ServiceLocator {
  void init() {
    ///bloc
    servicelocator.registerFactory<AuthBloc>(
        () => AuthBloc(servicelocator(), servicelocator(), servicelocator()));

    ///usecase
    servicelocator.registerLazySingleton<SignUpUsecase>(
        () => SignUpUsecase(servicelocator()));
    servicelocator.registerLazySingleton<LoginUsecase>(
        () => LoginUsecase(servicelocator()));
    servicelocator.registerLazySingleton<ForgetPasswordUsecase>(
        () => ForgetPasswordUsecase(servicelocator()));

    ///repository
    servicelocator.registerLazySingleton<BaseAuthRepository>(
        () => AuthRepositoryImple(servicelocator()));

    ///datasource
    servicelocator.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl());
  }
}
