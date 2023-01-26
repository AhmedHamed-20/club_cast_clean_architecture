import '../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import 'package:club_cast_clean_architecture/core/widgets/main_podcast_info_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/base_podcast_entitie/base_podcast_entitie.dart';
import '../utl/utls.dart';

class PodcastInformationScreen extends StatefulWidget {
  const PodcastInformationScreen(
      {super.key, required this.podcastInformationEntitie});
  final BasePodcastEntitie podcastInformationEntitie;
  @override
  State<PodcastInformationScreen> createState() =>
      _PodcastInformationScreenState();
}

class _PodcastInformationScreenState extends State<PodcastInformationScreen> {
  @override
  void initState() {
    BlocProvider.of<CommonPlayingPodcastBlocBloc>(context).add(
      PodcastBackGroundColorGenerateEvent(
        widget.podcastInformationEntitie.podcastUserInfo.userImage,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommonPlayingPodcastBlocBloc,
        CommonPlayingPodcastBlocState>(builder: (context, state) {
      switch (state.podcastInfoScreenColorsGenerateRequestStatus) {
        case BackGroundColorGenerateRequestStatus.loading:
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        case BackGroundColorGenerateRequestStatus.generated:
          return MainPodcastInfoWidget(
              podcastInformationEntitie: widget.podcastInformationEntitie,
              backGroundColor: state.backGroundColors.first.color);
        case BackGroundColorGenerateRequestStatus.error:
          return MainPodcastInfoWidget(
              podcastInformationEntitie: widget.podcastInformationEntitie,
              backGroundColor: Theme.of(context).colorScheme.background);
      }
    });
  }
}
