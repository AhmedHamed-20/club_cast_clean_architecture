import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/admin_entitie.dart';

import 'active_room_user_model.dart';

class AdminModel extends AdminEntitie {
  const AdminModel(super.admin);

  factory AdminModel.fromJson(List<dynamic> json) {
    return AdminModel(
      ActiveRoomUserModel.fromJson(json[1]['admin']),
    );
  }
}
