// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:club_cast_clean_architecture/core/layout/domain/entities/my_following_events_data_entity.dart';
import 'package:equatable/equatable.dart';

class MyFollowingEventsEntitie extends Equatable {
  final int results;
  final List<MyFollowingEventsDataEntity> myFollowingEventsDataEntity;
  const MyFollowingEventsEntitie(
      {required this.results, required this.myFollowingEventsDataEntity});

  MyFollowingEventsEntitie copyWith({
    int? results,
    List<MyFollowingEventsDataEntity>? myFollowingEventsDataEntity,
  }) {
    return MyFollowingEventsEntitie(
      results: results ?? this.results,
      myFollowingEventsDataEntity:
          myFollowingEventsDataEntity ?? this.myFollowingEventsDataEntity,
    );
  }

  @override
  List<Object?> get props => [
        myFollowingEventsDataEntity,
        results,
      ];
}
