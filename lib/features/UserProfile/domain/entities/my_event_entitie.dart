import 'package:equatable/equatable.dart';

import 'my_events_data_entitie.dart';

class MyEventsEntitie extends Equatable {
  final int results;
  final List<MyEventsDataEntitie> myEventsDataEntitie;

  const MyEventsEntitie(
      {required this.results, required this.myEventsDataEntitie});

  @override
  List<Object?> get props => [results, myEventsDataEntitie];
}
