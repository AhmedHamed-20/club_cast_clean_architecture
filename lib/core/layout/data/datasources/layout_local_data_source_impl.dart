import 'package:club_cast_clean_architecture/core/cache/cache_setup.dart';
import 'package:club_cast_clean_architecture/core/error/error_message_model.dart';
import 'package:club_cast_clean_architecture/core/error/exception.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_cached_access_token.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/usecases/get_cached_app_language.dart';

import '../../../services/service_locator.dart';
import '../../domain/usecases/cache_active_color_value.dart';
import '../../domain/usecases/cache_active_theme_value.dart';
import '../../domain/usecases/cache_app_languages.dart';
import '../../domain/usecases/get_cached_app_color_value.dart';
import '../../domain/usecases/get_cached_theme_value.dart';
import '../../domain/usecases/remove_access_token.dart';
import '../../domain/usecases/update_cached_access_token.dart';

abstract class BaseLayoutLocalDataSource {
  Future<String> accessTokenGetFromCache(CachedAccessTokenGetParams params);
  Future<void> updateCachedAccessToken(CachedAccessTokenUpdateParams params);

  Future<void> removeCachedAccessToken(AccessTokenRemoveParams params);
  Future<bool> getCachedThemeValue(GetThemeDataValueFromCacheParams params);
  Future<void> cacheThemeValue(ThemeDataValueCacheParams params);
  Future<String> getCachedAppColorValue(GetCachedAppColorValueParams params);
  Future<String> getCachedAppLangaugeValue(GetCachedAppLanguageParams params);

  Future<void> cacheAppColor(CacheAppColorsParams params);
  Future<void> cacheAppLanguage(AppLaguagesCacheParams params);
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

  @override
  Future<void> cacheThemeValue(ThemeDataValueCacheParams params) async {
    try {
      await servicelocator<CacheHelper>()
          .setData(key: params.key, value: params.isDark);
    } on Exception catch (error) {
      throw CacheException(LocalErrorsMessageModel.fromException(error));
    }
  }

  @override
  Future<bool> getCachedThemeValue(
      GetThemeDataValueFromCacheParams params) async {
    try {
      final result = await servicelocator<CacheHelper>().getData(
        key: params.key,
      );
      return result ?? false;
    } on Exception catch (error) {
      throw CacheException(LocalErrorsMessageModel.fromException(error));
    }
  }

  @override
  Future<void> cacheAppColor(CacheAppColorsParams params) async {
    try {
      await servicelocator<CacheHelper>()
          .setData(key: params.key, value: params.color);
    } on Exception catch (error) {
      throw CacheException(LocalErrorsMessageModel.fromException(error));
    }
  }

  @override
  Future<String> getCachedAppColorValue(
      GetCachedAppColorValueParams params) async {
    try {
      final result = await servicelocator<CacheHelper>().getData(
        key: params.key,
      );
      return result ?? '';
    } on Exception catch (error) {
      throw CacheException(LocalErrorsMessageModel.fromException(error));
    }
  }

  @override
  Future<void> cacheAppLanguage(AppLaguagesCacheParams params) async {
    try {
      await servicelocator<CacheHelper>().setData(
        key: params.key,
        value: params.value,
      );
    } on Exception catch (error) {
      throw CacheException(LocalErrorsMessageModel.fromException(error));
    }
  }

  @override
  Future<String> getCachedAppLangaugeValue(
      GetCachedAppLanguageParams params) async {
    try {
      final result = await servicelocator<CacheHelper>().getData(
        key: params.key,
      );
      return result ?? 'en';
    } on Exception catch (error) {
      throw CacheException(LocalErrorsMessageModel.fromException(error));
    }
  }
}
