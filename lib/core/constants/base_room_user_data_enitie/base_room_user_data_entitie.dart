import 'package:equatable/equatable.dart';

abstract class BaseRoomUserDataEntitie extends Equatable {
  final String id;
  final String name;
  final String photo;
  final int uid;

  const BaseRoomUserDataEntitie(
      {required this.id,
      required this.name,
      required this.photo,
      required this.uid});
}
