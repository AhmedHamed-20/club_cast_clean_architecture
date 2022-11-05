part of 'podcast_bloc.dart';

abstract class PodcastState extends Equatable {
  const PodcastState();  

  @override
  List<Object> get props => [];
}
class PodcastInitial extends PodcastState {}
