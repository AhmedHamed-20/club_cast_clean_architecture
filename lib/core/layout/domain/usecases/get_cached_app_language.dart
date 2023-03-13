import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/base_layout_repository.dart';

class GetCachedAppLanguageUsecase
    extends BaseUsecase<String, GetCachedAppLanguageParams> {
  final BaseLayoutRepository baseLayoutRepository;

  GetCachedAppLanguageUsecase(this.baseLayoutRepository);
  @override
  Future<Either<Failure, String>> call(
      GetCachedAppLanguageParams params) async {
    return await baseLayoutRepository.getCachedAppLanguageValue(params);
  }
}

class GetCachedAppLanguageParams extends Equatable {
  final String key;

  const GetCachedAppLanguageParams(this.key);

  @override
  List<Object?> get props => [key];
}
