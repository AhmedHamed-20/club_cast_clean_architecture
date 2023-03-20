import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_events_data_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_event.dart';

class OtherUserEventsModel extends OtherUserEventsEntity {
  const OtherUserEventsModel({required super.results, required super.events});
  factory OtherUserEventsModel.fromJson(Map<String, dynamic> json) {
    return OtherUserEventsModel(
      results: json['results'],
      events: (json['data'] as List)
          .map((e) => OtherUserEventsDataModel.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [results, events];
}
