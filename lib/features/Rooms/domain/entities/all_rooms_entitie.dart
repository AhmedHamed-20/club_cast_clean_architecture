// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'all_rooms_entity_data.dart';

class AllRoomsEntitie extends Equatable {
  final int results;
  final List<AllRoomsDataEntity> allRoomsDataEntitie;

  const AllRoomsEntitie(
      {required this.results, required this.allRoomsDataEntitie});

  AllRoomsEntitie copyWith({
    int? results,
    List<AllRoomsDataEntity>? allRoomsDataEntitie,
  }) {
    return AllRoomsEntitie(
      results: results ?? this.results,
      allRoomsDataEntitie: allRoomsDataEntitie ?? this.allRoomsDataEntitie,
    );
  }

  @override
  List<Object?> get props => [results, allRoomsDataEntitie];
}
