import 'package:equatable/equatable.dart';

class EventUserInfoEntity extends Equatable {
  final String userName;
  final String userPhoto;
  final String uid;

  const EventUserInfoEntity(
      {required this.userName, required this.userPhoto, required this.uid});

  @override
  List<Object?> get props => [userName, userName, uid];
}
