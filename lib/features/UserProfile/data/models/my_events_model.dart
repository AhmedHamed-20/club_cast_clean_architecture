import '../../domain/entities/my_event_entitie.dart';
import 'my_events_data_model.dart';

class MyEventsModel extends MyEventsEntitie {
  const MyEventsModel(
      {required super.results, required super.myEventsDataEntitie});

  factory MyEventsModel.fromJson(Map<String, dynamic> json) {
    return MyEventsModel(
      results: json['results'],
      myEventsDataEntitie: json['data']
          .map<MyEventsDataModel>((e) => MyEventsDataModel.fromJson(e))
          .toList(),
    );
  }
}
