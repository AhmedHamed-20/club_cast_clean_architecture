part of 'rooms_bloc.dart';

abstract class RoomsEvent extends Equatable {
  const RoomsEvent();
}

class AllRoomsGetEvent extends RoomsEvent {
  final String accessToken;

  const AllRoomsGetEvent({required this.accessToken});

  @override
  List<Object?> get props => [accessToken];
}
