import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/Search/presentation/bloc/search_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/AppStrings/app_strings.dart';
import '../../../../core/utl/utls.dart';
import '../../../../core/widgets/error_screen.dart';
import '../widgets/main_all_podcasts_widget.dart';

bool isEndOfAllPodcasts = false;
int allPodcastPage = 2;
late ScrollController allPodcastScrollController;

class AllPodcastsScreen extends StatefulWidget {
  const AllPodcastsScreen({super.key});

  @override
  State<AllPodcastsScreen> createState() => _AllPodcastsScreenState();
}

class _AllPodcastsScreenState extends State<AllPodcastsScreen> {
  @override
  void initState() {
    super.initState();
    getAllPodcasts();
    listenToScrollController();
  }

  @override
  void dispose() {
    disposeScrollControllerAndResetValues();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.allPodcasts.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          isEndOfAllPodcasts = state.isEndOfAllPodcasts;
        },
        builder: (context, state) {
          switch (state.allPodcastsRequestStatus) {
            case SearchRequestStatus.idle:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case SearchRequestStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case SearchRequestStatus.success:
              return MainAllPodcastWidget(
                podcastInformationEntitie: state.allPodcastsEntitie,
              );
            case SearchRequestStatus.error:
              if (state.statusCode == 403 || state.statusCode == 401) {
                return ErrorScreen(
                  message: state.errorMessages,
                  statusCode: state.statusCode,
                  isHoleScreen: true,
                );
              } else {
                return ErrorScreen(
                  message: state.errorMessages,
                  isHoleScreen: true,
                  onRetry: () {
                    getAllPodcasts();
                  },
                );
              }
          }
        },
      ),
    );
  }

  void getAllPodcasts() {
    BlocProvider.of<SearchBloc>(context).add(
      AllPodcastEvent(accessToken: ConstVar.accessToken, page: 1),
    );
  }

  void listenToScrollController() {
    allPodcastScrollController = ScrollController();
    allPodcastScrollController.addListener(() {
      if (allPodcastScrollController.position.pixels ==
              allPodcastScrollController.position.maxScrollExtent &&
          isEndOfAllPodcasts == false) {
        BlocProvider.of<SearchBloc>(context).add(AllPodcastGetMoreEvent(
            accessToken: ConstVar.accessToken, page: allPodcastPage));
        allPodcastPage++;
      }
    });
  }

  void disposeScrollControllerAndResetValues() {
    allPodcastScrollController.dispose();
    allPodcastPage = 2;
    isEndOfAllPodcasts = false;
  }
}
