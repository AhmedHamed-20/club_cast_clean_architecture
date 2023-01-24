import 'package:equatable/equatable.dart';

class RoomUserDataEntitie extends Equatable {
  final String id;
  final String name;
  final String photo;
  final int uid;

  const RoomUserDataEntitie(
      {required this.id,
      required this.name,
      required this.photo,
      required this.uid});

  @override
  List<Object?> get props => [id, name, photo, uid];
}
