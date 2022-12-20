import '../../../../core/cache/chache_setup.dart';
import '../../../../core/error/error_message_model.dart';
import '../../../../core/error/exception.dart';
import '../../domain/usecases/cache_access_token.dart';

abstract class BaseAuthLocalDataSource {
  Future<bool> cacheAccessToken(AccessTokenCacheParams params);
}

class AuthLocalDataSourceImpl extends BaseAuthLocalDataSource {
  @override
  Future<bool> cacheAccessToken(AccessTokenCacheParams params) async {
    try {
      final result = await CacheHelper.setData(
          key: 'accessToken', value: params.accessToken);
      return result;
    } on Exception catch (error) {
      throw CacheException(LocalErrorsMessageModel.fromException(error));
    }
  }
}
