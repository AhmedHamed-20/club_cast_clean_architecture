import 'package:club_cast_clean_architecture/features/Rooms/data/models/all_rooms_user_data.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/all_rooms_entity_data.dart';

class AllRoomsDataModel extends AllRoomsDataEntity {
  const AllRoomsDataModel(
      {required super.id,
      required super.name,
      required super.category,
      required super.isRecording,
      required super.createdAt,
      required super.admin,
      required super.audience,
      required super.brodcasters});

  factory AllRoomsDataModel.fromJson(Map<String, dynamic> json) {
    return AllRoomsDataModel(
      id: json['_id'],
      name: json['name'],
      category: json['category'],
      isRecording: json['isRecording'],
      createdAt: json['createdAt'],
      admin: RoomsUserDataModel.fromJson(json['admin']),
      audience: List<RoomsUserDataModel>.from(
          json['audience'].map((e) => RoomsUserDataModel.fromJson(e))),
      brodcasters: List<RoomsUserDataModel>.from(
          json['brodcasters'].map((e) => RoomsUserDataModel.fromJson(e))),
    );
  }
}
