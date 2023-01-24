import 'package:equatable/equatable.dart';

import 'all_rooms_entitie_data.dart';

class AllRoomsEntitie extends Equatable {
  final int results;
  final List<AllRoomsDataEntitie> allRoomsDataEntitie;

  const AllRoomsEntitie(
      {required this.results, required this.allRoomsDataEntitie});

  @override
  List<Object?> get props => [results, allRoomsDataEntitie];
}
