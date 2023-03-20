// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'my_events_data_entity.dart';

class MyEventsEntity extends Equatable {
  final int results;
  final List<MyEventsDataEntity> myEventsDataEntitie;

  const MyEventsEntity(
      {required this.results, required this.myEventsDataEntitie});

  MyEventsEntity copyWith({
    int? results,
    List<MyEventsDataEntity>? myEventsDataEntitie,
  }) {
    return MyEventsEntity(
      results: results ?? this.results,
      myEventsDataEntitie: myEventsDataEntitie ?? this.myEventsDataEntitie,
    );
  }

  @override
  List<Object?> get props => [results, myEventsDataEntitie];
}
