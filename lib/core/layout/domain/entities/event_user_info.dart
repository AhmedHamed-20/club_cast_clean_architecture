import 'package:equatable/equatable.dart';

class EventUserInfoEntitie extends Equatable {
  final String userName;
  final String userPhoto;
  final String uid;

  const EventUserInfoEntitie(
      {required this.userName, required this.userPhoto, required this.uid});

  @override
  List<Object?> get props => [userName, userName, uid];
}
