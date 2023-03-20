import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/me_entity.dart';

import 'active_room_user_model.dart';

class MeModel extends MeEntity {
  const MeModel(super.me);

  factory MeModel.fromJson(List<dynamic> json) {
    return MeModel(
      ActiveRoomUserModel.fromJson(json[0]),
    );
  }
}
