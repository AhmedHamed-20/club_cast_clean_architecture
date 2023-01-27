import 'package:club_cast_clean_architecture/core/cache/chache_setup.dart';
import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_cached_access_token.dart';

import '../../../services/service_locator.dart';
import '../../domain/usecases/remove_access_token.dart';
import '../../domain/usecases/update_cached_access_token.dart';

abstract class BaseLayoutLocalDataSource {
  Future<String> accessTokenGetFromCache(CachedAccessTokenGetParams params);
  Future<void> updateCachedAccessToken(CachedAccessTokenUpdateParams params);

  Future<void> removeCachedAccessToken(AccessTokenRemoveParams params);
}

class LayoutLocalDataSourceImpl extends BaseLayoutLocalDataSource {
  @override
  Future<String> accessTokenGetFromCache(
      CachedAccessTokenGetParams params) async {
    try {
      final result =
          await servicelocator<CacheHelper>().getData(key: params.key);
      return result;
    } on Exception catch (error) {
      throw CacheException(LocalErrorsMessageModel.fromException(error));
    }
  }

  @override
  Future<void> updateCachedAccessToken(
      CachedAccessTokenUpdateParams params) async {
    try {
      await servicelocator<CacheHelper>()
          .setData(key: params.key, value: params.value);
    } on Exception catch (error) {
      throw CacheException(LocalErrorsMessageModel.fromException(error));
    }
  }

  @override
  Future<void> removeCachedAccessToken(AccessTokenRemoveParams params) async {
    try {
      await servicelocator<CacheHelper>().removeData(params.key);
    } on Exception catch (error) {
      throw CacheException(LocalErrorsMessageModel.fromException(error));
    }
  }
}
