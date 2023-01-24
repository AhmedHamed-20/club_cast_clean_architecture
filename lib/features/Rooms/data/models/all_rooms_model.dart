import 'package:club_cast_clean_architecture/features/Rooms/data/models/all_rooms_data_model.dart';
import 'package:club_cast_clean_architecture/features/Rooms/domain/entities/all_rooms_entitie.dart';

class AllRoomsModel extends AllRoomsEntitie {
  const AllRoomsModel(
      {required super.results, required super.allRoomsDataEntitie});

  factory AllRoomsModel.fromJson(Map<String, dynamic> json) {
    return AllRoomsModel(
      results: json['results'],
      allRoomsDataEntitie: List<AllRoomsDataModel>.from(
        json['data'].map(
          (e) => AllRoomsDataModel.fromJson(e),
        ),
      ),
    );
  }
}
