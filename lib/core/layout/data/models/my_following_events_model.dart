import 'package:club_cast_clean_architecture/core/layout/data/models/my_following_events_data_model.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/my_following_events_entitie.dart';

class MyFollowingEventsModel extends MyFollowingEventsEntitie {
  const MyFollowingEventsModel(
      {required super.results, required super.myFollowingEventsDataEntitie});

  factory MyFollowingEventsModel.fromJson(Map<String, dynamic> json) {
    return MyFollowingEventsModel(
        results: json['results'],
        myFollowingEventsDataEntitie: List<MyFollowingEventsDataModel>.from(
          json['data'].map(
            (x) => MyFollowingEventsDataModel.fromJson(x),
          ),
        ));
  }
}
