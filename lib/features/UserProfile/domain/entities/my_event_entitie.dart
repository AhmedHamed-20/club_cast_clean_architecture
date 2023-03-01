// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'my_events_data_entitie.dart';

class MyEventsEntitie extends Equatable {
  final int results;
  final List<MyEventsDataEntitie> myEventsDataEntitie;

  const MyEventsEntitie(
      {required this.results, required this.myEventsDataEntitie});

  MyEventsEntitie copyWith({
    int? results,
    List<MyEventsDataEntitie>? myEventsDataEntitie,
  }) {
    return MyEventsEntitie(
      results: results ?? this.results,
      myEventsDataEntitie: myEventsDataEntitie ?? this.myEventsDataEntitie,
    );
  }

  @override
  List<Object?> get props => [results, myEventsDataEntitie];
}
