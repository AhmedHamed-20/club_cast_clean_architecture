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
