// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_data_entity.dart';

class MyPodcastEntity extends Equatable {
  final int results;
  final List<MyPodcastDataEntity> myPodcastDataEntitie;

  const MyPodcastEntity(
      {required this.results, required this.myPodcastDataEntitie});

  MyPodcastEntity copyWith({
    int? results,
    List<MyPodcastDataEntity>? myPodcastDataEntitie,
  }) {
    return MyPodcastEntity(
      results: results ?? this.results,
      myPodcastDataEntitie: myPodcastDataEntitie ?? this.myPodcastDataEntitie,
    );
  }

  @override
  List<Object?> get props => [results, myPodcastDataEntitie];
}
