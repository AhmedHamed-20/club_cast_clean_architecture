part of 'layout_bloc.dart';

abstract class LayoutEvent extends Equatable {
  const LayoutEvent();
}

class ActiveUserDataGetEvent extends LayoutEvent {
  final String accessToken;

  const ActiveUserDataGetEvent(this.accessToken);

  @override
  List<Object?> get props => [accessToken];
}

class AccessTokenGetFromCacheEvent extends LayoutEvent {
  final String key;

  const AccessTokenGetFromCacheEvent(this.key);

  @override
  List<Object?> get props => [key];
}

class MyFollowingEventsGetEvent extends LayoutEvent {
  final String accessToken;

  const MyFollowingEventsGetEvent(this.accessToken);

  @override
  List<Object?> get props => [accessToken];
}

class MyFollowingEventsGetMoreEvent extends LayoutEvent {
  final String accessToken;
  final int page;

  const MyFollowingEventsGetMoreEvent(this.accessToken, this.page);

  @override
  List<Object?> get props => [accessToken, page];
}

class BottomNavIndexChangeEvent extends LayoutEvent {
  final int index;

  const BottomNavIndexChangeEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class CategoriesGetEvent extends LayoutEvent {
  const CategoriesGetEvent();

  @override
  List<Object?> get props => [];
}

class UserDataUpdateEvent extends LayoutEvent {
  final BaseUserDataEntity userDataEntitie;

  const UserDataUpdateEvent({
    required this.userDataEntitie,
  });

  @override
  List<Object?> get props => [userDataEntitie];
}

class AccessTokenRemoveEvent extends LayoutEvent {
  final String key;

  const AccessTokenRemoveEvent({
    required this.key,
  });

  @override
  List<Object?> get props => [key];
}

class CachedAccessTokenUpdateEvent extends LayoutEvent {
  final String key;
  final String value;

  const CachedAccessTokenUpdateEvent({
    required this.key,
    required this.value,
  });

  @override
  List<Object?> get props => [key, value];
}

class BottomSheetStatusEvent extends LayoutEvent {
  final LayoutBottomSheetStatus layoutBottomSheetStatus;

  const BottomSheetStatusEvent({
    required this.layoutBottomSheetStatus,
  });

  @override
  List<Object?> get props => [layoutBottomSheetStatus];
}

class CacheThemeValueEvent extends LayoutEvent {
  final String key;
  final bool isDark;

  const CacheThemeValueEvent({required this.key, required this.isDark});

  @override
  List<Object?> get props => [key, isDark];
}

class GetChachedThemeValueEvent extends LayoutEvent {
  final String key;

  const GetChachedThemeValueEvent({required this.key});

  @override
  List<Object?> get props => [key];
}

class GetCachedAppColorsValueEvent extends LayoutEvent {
  final String key;
  const GetCachedAppColorsValueEvent({required this.key});

  @override
  List<Object?> get props => [key];
}

class CacheAppColorsValueEvent extends LayoutEvent {
  final String key;
  final String color;
  const CacheAppColorsValueEvent({required this.key, required this.color});

  @override
  List<Object?> get props => [key, color];
}

class CacheAppLanguageEvent extends LayoutEvent {
  final String key;
  final String language;
  final BuildContext context;
  const CacheAppLanguageEvent(
      {required this.key, required this.language, required this.context});

  @override
  List<Object?> get props => [key, language, context];
}

class GetCachedAppLanguageEvent extends LayoutEvent {
  final String key;
  const GetCachedAppLanguageEvent({
    required this.key,
  });

  @override
  List<Object?> get props => [
        key,
      ];
}
