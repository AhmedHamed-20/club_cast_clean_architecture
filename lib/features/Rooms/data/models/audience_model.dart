import 'package:club_cast_clean_architecture/features/Rooms/data/models/active_room_user_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/audience_entite.dart';

class AudiencesModel extends AudienceEntitie {
  const AudiencesModel(super.audience);

  factory AudiencesModel.fromJson(Map<String, dynamic> json) {
    return AudiencesModel((json[1]['audience'] as List)
        .map((e) => ActiveRoomUserModel.fromJson(e))
        .toList());
  }
}