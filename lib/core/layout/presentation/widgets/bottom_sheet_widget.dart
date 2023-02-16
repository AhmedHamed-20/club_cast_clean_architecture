import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/widgets/podcast_bottom_sheet_widget.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/widgets/rooms_bottom_sheet_widget.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utl/utls.dart';

class MainLayoutBottomSheetWidget extends StatelessWidget {
  const MainLayoutBottomSheetWidget(
      {super.key, required this.layoutBottomSheetStatus});
  final LayoutBottomSheetStatus layoutBottomSheetStatus;
  @override
  Widget build(BuildContext context) {
    switch (layoutBottomSheetStatus) {
      case LayoutBottomSheetStatus.idle:
        return const SizedBox.shrink();
      case LayoutBottomSheetStatus.playingPodcast:
        return BlocBuilder<CommonPlayingPodcastBlocBloc,
            CommonPlayingPodcastBlocState>(builder: (context, state) {
          return PodcastBottomSheetWidget(
            basePodcastEntitie: state.currentPlayingPodcastEntitie,
          );
        });
      case LayoutBottomSheetStatus.playingLiveVoiceRoom:
        return BlocBuilder<SocketsVoiceBloc, SocketsVoiceState>(
            builder: (context, state) {
          return RoomsBottomSheetWidget(
            joinCreateRoomEntitie: state.joinCreateRoomEntitie,
          );
        });
    }
  }
}
