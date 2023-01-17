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
  final BaseUserDataEntitie userDataEntitie;

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
