import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/core/widgets/error_screen.dart';
import 'package:club_cast_clean_architecture/features/Search/presentation/bloc/search_bloc.dart';
import 'package:club_cast_clean_architecture/features/Search/presentation/widgets/podcast_search_main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/text_editing_controllers.dart';
import '../../../../core/routes/app_route_names.dart';
import '../../../../core/utl/utls.dart';

class PodcastSearchWidget extends StatelessWidget {
  const PodcastSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      switch (state.podcastSearchRequestStatus) {
        case SearchRequestStatus.idle:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('Search for podcasts',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              const SizedBox(
                height: AppPadding.p12,
              ),
              Defaults.defaultButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AppRoutesNames.allPodcastsScreen,
                      arguments: AllPodcastsScreenParams(searchBloc),
                    );
                  },
                  context: context,
                  text: 'Explore Podcasts',
                  width: MediaQueryOfMethods.getAppWidth(context) * 0.5),
            ],
          );
        case SearchRequestStatus.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case SearchRequestStatus.success:
          return const Padding(
              padding: EdgeInsets.all(AppPadding.p12),
              child: PodcastSearchMainWidget());

        case SearchRequestStatus.error:
          if (state.statusCode == 403 || state.statusCode == 401) {
            return ErrorScreen(
              isHoleScreen: false,
              message: state.errorMessages,
              statusCode: state.statusCode,
            );
          } else {
            return ErrorScreen(
              isHoleScreen: false,
              message: state.errorMessages,
              onRetry: () {
                BlocProvider.of<SearchBloc>(context).add(UsersSearchEvent(
                    accessToken: ConstVar.accessToken,
                    query: TextEditingControllers.searchController.text));
              },
            );
          }
      }
    });
  }
}
