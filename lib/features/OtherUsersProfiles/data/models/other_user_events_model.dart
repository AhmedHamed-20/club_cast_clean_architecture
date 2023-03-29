import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/data/models/other_user_events_data_model.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_event.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_events_data.dart';

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
  OtherUserEventsEntity copyWith(
      {int? results, List<OtherUserEventDataEntity>? events}) {
    return OtherUserEventsModel(
      results: results ?? this.results,
      events: events ?? this.events,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'results': results, 'data': events.map((e) => e.toJson()).toList()};
  }

  @override
  List<Object?> get props => [results, events];
}
