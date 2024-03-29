import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/presentation/bloc/podcast_bloc.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/presentation/widgets/podcast_card_main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'no_my_following_podcasts_widget.dart';

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
  ScrollController scrollController = ScrollController();
  bool isEndOfData = false;
  @override
  void initState() {
    super.initState();
    addScrollListener();
  }

  @override
  void dispose() async {
    myFollowingPodcastsPage = 2;
    isEndOfData = false;
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myFollowingPodcasts = BlocProvider.of<PodcastBloc>(context);
    return BlocConsumer<PodcastBloc, PodcastState>(listener: (constext, state) {
      isEndOfData = state.isEndOfData;
    }, builder: (context, state) {
      if (state.myFollowingPodcasts!.podcastInformationEntitie.isEmpty) {
        return const NoMyFollowingPodcastsWidgets();
      } else {
        return RefreshIndicator(
          onRefresh: () async {
            myFollowingPodcasts.add(
                GetMyFollowingPodcastsEvent(accessToken: ConstVar.accessToken));
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            itemCount:
                state.myFollowingPodcasts!.podcastInformationEntitie.length + 1,
            itemBuilder: (context, index) {
              if (index <
                  state.myFollowingPodcasts!.podcastInformationEntitie.length) {
                return Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: MyFollowingPodcastCardMainWdget(
                    index: index,
                    podcastsEntitie: state.myFollowingPodcasts!,
                  ),
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
    });
  }

  void addScrollListener() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          isEndOfData == false) {
        BlocProvider.of<PodcastBloc>(context).add(
          MoreMyFollowingPodcastsGetEvent(
            accessToken: ConstVar.accessToken,
            page: myFollowingPodcastsPage,
          ),
        );
        myFollowingPodcastsPage++;
      }
    });
  }
}
