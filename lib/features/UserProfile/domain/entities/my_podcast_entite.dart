// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_data_entitie.dart';

class MyPodcastEntitie extends Equatable {
  final int results;
  final List<MyPodcastDataEntite> myPodcastDataEntitie;

  const MyPodcastEntitie(
      {required this.results, required this.myPodcastDataEntitie});

  MyPodcastEntitie copyWith({
    int? results,
    List<MyPodcastDataEntite>? myPodcastDataEntitie,
  }) {
    return MyPodcastEntitie(
      results: results ?? this.results,
      myPodcastDataEntitie: myPodcastDataEntitie ?? this.myPodcastDataEntitie,
    );
  }

  @override
  List<Object?> get props => [results, myPodcastDataEntitie];
}
