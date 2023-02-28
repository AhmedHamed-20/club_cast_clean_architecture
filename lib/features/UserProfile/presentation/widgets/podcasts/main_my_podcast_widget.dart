import 'package:club_cast_clean_architecture/features/UserProfile/domain/entities/my_podcast_data_entitie.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/defaults.dart';
import '../../../../../core/widgets/podcast_card_widgets/podcast_card_widget.dart';

class MainMyPodcastWidget extends StatelessWidget {
  const MainMyPodcastWidget({
    required this.myPodcastEntite,
    Key? key,
  }) : super(key: key);
  final List<MyPodcastDataEntite> myPodcastEntite;
  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    final commonPlayingPodcastBloc =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);
    return ListView.builder(
      itemCount: myPodcastEntite.length,
      itemBuilder: (context, index) {
        return BlocBuilder<CommonPlayingPodcastBlocBloc,
                CommonPlayingPodcastBlocState>(
            builder: (context, commonPlayPodcastBlocState) {
          final defaultPodcastCallBackParams = DefaultPodcastCallBackParams(
            basePodcastEntitie: myPodcastEntite[index],
            commonPlayingPodcastBloc: commonPlayingPodcastBloc,
            context: context,
            state: commonPlayPodcastBlocState,
          );
          return Padding(
            padding: const EdgeInsets.only(bottom: AppPadding.p8),
            child: PodcastCardWidget(
              podcastEntitie: myPodcastEntite[index],
              isMyProfile: true,
              podcastCardCallBacksParams:
                  defaultPodcastCallBackParams.defaultPodcastCallBackParams(
                      userProfileBloc: userProfileBloc),
              podcastDurathion:
                  commonPlayingPodcastBloc.getCurrentPlayingPosition(
                currentPosition: commonPlayPodcastBlocState.currentPosition,
                podcastId: myPodcastEntite[index].podcastId,
                podcastDuration:
                    myPodcastEntite[index].podcastInfo.podcastDuration,
              ),
            ),
          );
        });
      },
    );
  }
}
