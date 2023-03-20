import 'package:club_cast_clean_architecture/features/Rooms/data/models/active_room_user_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/audience_entity.dart';

class AudiencesModel extends AudienceEntity {
  const AudiencesModel(super.audience);

  factory AudiencesModel.fromJson(List<dynamic> json) {
    return AudiencesModel((json[1]['audience'] as List)
        .map((e) => ActiveRoomUserModel.fromJson(e))
        .toList());
  }
}
