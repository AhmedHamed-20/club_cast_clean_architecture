import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_data_entitie.dart';
import 'package:equatable/equatable.dart';

class MyPodcastEntitie extends Equatable {
  final int results;
  final List<MyPodcastDataEntite> myPodcastDataEntitie;

  const MyPodcastEntitie(
      {required this.results, required this.myPodcastDataEntitie});

  @override
  List<Object?> get props => [results, myPodcastDataEntitie];
}
