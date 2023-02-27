import 'package:club_cast_clean_architecture/core/error/failure.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/repositories/base_layout_repository.dart';
import 'package:club_cast_clean_architecture/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCachedAppColorValueFromCacheUssecase
    extends BaseUsecase<String, GetCachedAppColorValueParams> {
  final BaseLayoutRepository baseLayoutRepository;

  GetCachedAppColorValueFromCacheUssecase(this.baseLayoutRepository);
  @override
  Future<Either<Failure, String>> call(
      GetCachedAppColorValueParams params) async {
    return await baseLayoutRepository.getCachedAppColorValue(params);
  }
}

class GetCachedAppColorValueParams extends Equatable {
  final String key;

  const GetCachedAppColorValueParams({
    required this.key,
  });

  @override
  List<Object?> get props => [
        key,
      ];
}
