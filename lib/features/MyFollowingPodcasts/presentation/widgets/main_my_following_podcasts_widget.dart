import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/presentation/bloc/podcast_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/layout/presentation/widgets/podcast_card_widget.dart';

int myFollowingPodcastsPage = 2;

class MainMyFollowingPodcastsWidget extends StatefulWidget {
  const MainMyFollowingPodcastsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MainMyFollowingPodcastsWidget> createState() =>
      _MainMyFollowingPodcastsWidgetState();
}

class _MainMyFollowingPodcastsWidgetState
    extends State<MainMyFollowingPodcastsWidget> {
  final ScrollController scrollController = ScrollController();
  bool isEndOfData = false;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          isEndOfData == false) {
        BlocProvider.of<PodcastBloc>(context).add(
          MoreMyFollowingPodcastsGetEvent(
            accessToken: ConstVar.accessToken,
            page: myFollowingPodcastsPage.toString(),
          ),
        );
        myFollowingPodcastsPage++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PodcastBloc, PodcastState>(
      listener: (constext, state) {
        isEndOfData = state.isEndOfData;
      },
      builder: (context, state) => ListView.builder(
        controller: scrollController,
        itemCount:
            state.myFollowingPodcasts!.podcastInformationEntitie.length + 1,
        itemBuilder: (context, index) {
          if (index <
              state.myFollowingPodcasts!.podcastInformationEntitie.length) {
            return PodcastCardWidget(
              onPressedOnCard: () {},
              onPressedOnUserPhoto: () {},
              onPressedOnLikeButton: () {},
              isLiked: state.myFollowingPodcasts!
                  .podcastInformationEntitie[index].isLiked,
              podcastDurathion: state.myFollowingPodcasts!
                  .podcastInformationEntitie[index].podcastInfo.podcastDuration,
              podcastLikes: state.myFollowingPodcasts!
                  .podcastInformationEntitie[index].podcastLikesCount,
              podcastName: state.myFollowingPodcasts!
                  .podcastInformationEntitie[index].podcastName,
              podcastPhoto: state.myFollowingPodcasts!
                  .podcastInformationEntitie[index].podcastUserInfo.userImage,
              podcastUserName: state.myFollowingPodcasts!
                  .podcastInformationEntitie[index].podcastUserInfo.userName,
            );
          } else {
            return state.isEndOfData
                ? const SizedBox.shrink()
                : const Center(
                    child: Padding(
                        padding: EdgeInsets.all(AppPadding.p8),
                        child: CircularProgressIndicator()),
                  );
          }
        },
      ),
    );
  }
}
