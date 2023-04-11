import 'package:equatable/equatable.dart';

abstract class BaseRoomUserDataEntity extends Equatable {
  final String id;
  final String name;
  final String photo;
  final int uid;

  const BaseRoomUserDataEntity(
      {required this.id,
      required this.name,
      required this.photo,
      required this.uid});

  Map<String, dynamic> toJson();
}
