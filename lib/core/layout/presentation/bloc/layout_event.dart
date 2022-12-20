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
