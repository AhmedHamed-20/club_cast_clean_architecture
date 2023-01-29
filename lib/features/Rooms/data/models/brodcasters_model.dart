import 'package:club_cast_clean_architecture/features/Rooms/data/models/active_room_user_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/brodcasters_entitie.dart';

class BrodCasterssModel extends BrodcastersEnitite {
  const BrodCasterssModel(super.audience);

  factory BrodCasterssModel.fromJson(List<dynamic> json) {
    return BrodCasterssModel((json[1]['brodcasters'] as List)
        .map((e) => ActiveRoomUserModel.fromJson(e))
        .toList());
  }
}
