import 'package:club_cast_clean_architecture/features/Rooms/data/models/active_room_user_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/audience_entite.dart';

class AudiencesModel extends AudienceEntitie {
  const AudiencesModel(super.audience);

  factory AudiencesModel.fromJson(List<dynamic> json, bool isCreateRoom) {
    if (isCreateRoom) {
      return AudiencesModel((json[1]['audience'] as List)
          .map((e) => ActiveRoomUserModel.fromJson(e))
          .toList());
    } else {
      List audience = json[1]['audience'] as List;
      audience.removeLast();
      print(audience);

      return AudiencesModel(
          (audience).map((e) => ActiveRoomUserModel.fromJson(e)).toList());
    }
  }
}
