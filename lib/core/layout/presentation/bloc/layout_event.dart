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
