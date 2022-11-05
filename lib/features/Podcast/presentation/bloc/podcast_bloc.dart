import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'podcast_event.dart';
part 'podcast_state.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  PodcastBloc() : super(PodcastInitial()) {
    on<PodcastEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
