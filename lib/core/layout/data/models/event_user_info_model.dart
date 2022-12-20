import 'package:club_cast_clean_architecture/core/layout/domain/entities/event_user_info.dart';

class EventUserInfoModel extends EventUserInfoEntitie {
  const EventUserInfoModel(
      {required super.userName, required super.userPhoto, required super.uid});

  factory EventUserInfoModel.fromJson(Map<String, dynamic> json) {
    return EventUserInfoModel(
      userName: json['name'],
      userPhoto: json['photo'],
      uid: json['_id'],
    );
  }
}
