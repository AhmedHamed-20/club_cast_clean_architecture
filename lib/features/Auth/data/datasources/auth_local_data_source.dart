import '../../../../core/cache/cache_setup.dart';
import '../../../../core/error/error_message_model.dart';
import '../../../../core/error/exception.dart';
import '../../domain/usecases/cache_access_token.dart';

abstract class BaseAuthLocalDataSource {
  Future<bool> cacheAccessToken(AccessTokenCacheParams params);
}

class AuthLocalDataSourceImpl extends BaseAuthLocalDataSource {
  final CacheService _cacheService;

  AuthLocalDataSourceImpl(this._cacheService);
  @override
  Future<bool> cacheAccessToken(AccessTokenCacheParams params) async {
    try {
      final result = await _cacheService.setData(
          key: 'accessToken', value: params.accessToken);
      return result;
    } on Exception catch (error) {
      throw CacheException(LocalErrorsMessageModel.fromException(error));
    }
  }
}
