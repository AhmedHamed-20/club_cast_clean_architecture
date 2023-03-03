import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/MyPodcastBloc/my_podcast_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/widgets/defaults.dart';
import '../../../../../core/widgets/podcast_card_widgets/podcast_card_widget.dart';

class MainMyPodcastWidget extends StatefulWidget {
  const MainMyPodcastWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MainMyPodcastWidget> createState() => _MainMyPodcastWidgetState();
}

class _MainMyPodcastWidgetState extends State<MainMyPodcastWidget> {
  late ScrollController myPodcastsScrollCotroller;
  bool isEndOfMyPodcastData = false;
  int myPodcastsPage = 2;
  @override
  void initState() {
    super.initState();
    addMyPodcastListener();
  }

  @override
  void dispose() {
    disposeScrollMyPodcastController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myPodcastBloc = BlocProvider.of<MyPodcastBloc>(context);
    final commonPlayingPodcastBloc =
        BlocProvider.of<CommonPlayingPodcastBlocBloc>(context);
    return BlocConsumer<MyPodcastBloc, MyPodcastState>(
        listener: (context, state) {
      isEndOfMyPodcastData = state.isEndOfMyPodcastsData;
    }, builder: (context, state) {
      return RefreshIndicator(
        onRefresh: () async {
          myPodcastBloc.add(
              MyPodcastsGetEvent(accessToken: ConstVar.accessToken, page: 1));
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: state.myPodcastEntite.myPodcastDataEntitie.length + 1,
          controller: myPodcastsScrollCotroller,
          itemBuilder: (context, index) {
            if (index < state.myPodcastEntite.myPodcastDataEntitie.length) {
              return BlocBuilder<CommonPlayingPodcastBlocBloc,
                      CommonPlayingPodcastBlocState>(
                  builder: (context, commonPlayPodcastBlocState) {
                final defaultPodcastCallBackParams =
                    DefaultPodcastCallBackParams(
                  basePodcastEntitie:
                      state.myPodcastEntite.myPodcastDataEntitie[index],
                  commonPlayingPodcastBloc: commonPlayingPodcastBloc,
                  context: context,
                  state: commonPlayPodcastBlocState,
                );
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppPadding.p8),
                  child: PodcastCardWidget(
                    podcastEntitie:
                        state.myPodcastEntite.myPodcastDataEntitie[index],
                    isMyProfile: true,
                    podcastCardCallBacksParams: defaultPodcastCallBackParams
                        .defaultPodcastCallBackParams(
                            myPodcastBloc: myPodcastBloc,
                            podcastBloc: myPodcastBloc,
                            podcastLikeCountChangeEvent:
                                UpdatePodcastLikesCountEvent(
                                    podcastId: state.myPodcastEntite
                                        .myPodcastDataEntitie[index].podcastId,
                                    isLiked: state.myPodcastEntite
                                        .myPodcastDataEntitie[index].isLiked)),
                    podcastDurathion:
                        commonPlayingPodcastBloc.getCurrentPlayingPosition(
                      currentPosition:
                          commonPlayPodcastBlocState.currentPosition,
                      podcastId: state.myPodcastEntite
                          .myPodcastDataEntitie[index].podcastId,
                      podcastDuration: state
                          .myPodcastEntite
                          .myPodcastDataEntitie[index]
                          .podcastInfo
                          .podcastDuration,
                    ),
                  ),
                );
              });
            } else {
              return state.isEndOfMyPodcastsData
                  ? const SizedBox.shrink()
                  : const Padding(
                      padding: EdgeInsets.all(AppPadding.p8),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
            }
          },
        ),
      );
    });
  }

  void addMyPodcastListener() {
    final myPodcastBloc = BlocProvider.of<MyPodcastBloc>(context);
    myPodcastsScrollCotroller = ScrollController();
    myPodcastsScrollCotroller.addListener(() {
      if (myPodcastsScrollCotroller.position.pixels ==
              myPodcastsScrollCotroller.position.maxScrollExtent &&
          isEndOfMyPodcastData == false) {
        myPodcastBloc.add(
          MyPodcastGetMoreEvents(
            accessToken: ConstVar.accessToken,
            page: myPodcastsPage,
          ),
        );
        myPodcastsPage++;
      }
    });
  }

  void disposeScrollMyPodcastController() {
    myPodcastsScrollCotroller.dispose();
    myPodcastsPage = 2;
    isEndOfMyPodcastData = false;
  }
}
