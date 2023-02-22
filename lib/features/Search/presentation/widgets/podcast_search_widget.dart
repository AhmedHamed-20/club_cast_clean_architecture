import 'package:club_cast_clean_architecture/core/widgets/error_screen.dart';
import 'package:club_cast_clean_architecture/features/Search/presentation/bloc/search_bloc.dart';
import 'package:club_cast_clean_architecture/features/Search/presentation/widgets/podcast_search_main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/text_editing_controllers.dart';
import '../../../../core/utl/utls.dart';

class PodcastSearchWidget extends StatelessWidget {
  const PodcastSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      switch (state.podcastSearchRequestStatus) {
        case SearchRequestStatus.idle:
          return Center(
            child: Text('Search for podcasts',
                style: Theme.of(context).textTheme.titleLarge),
          );
        case SearchRequestStatus.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case SearchRequestStatus.success:
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: ListView.builder(
              itemCount:
                  state.podcastSearchEntitie.podcastInformationEntitie.length,
              itemBuilder: (context, index) {
                return PodcastSearchMainWidget(
                  basePodcastEntitie: state
                      .podcastSearchEntitie.podcastInformationEntitie[index],
                );
              },
            ),
          );
        case SearchRequestStatus.error:
          if (state.statusCode == 403 || state.statusCode == 401) {
            return ErrorScreen(
              message: state.errorMessages,
              statusCode: state.statusCode,
            );
          } else {
            return ErrorScreen(
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
