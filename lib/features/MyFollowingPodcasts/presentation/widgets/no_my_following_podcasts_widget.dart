import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/core/services/service_locator.dart';
import 'package:club_cast_clean_architecture/features/Search/presentation/bloc/search_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/routes/app_route_names.dart';
import '../../../../core/widgets/defaults.dart';

class NoMyFollowingPodcastsWidgets extends StatelessWidget {
  const NoMyFollowingPodcastsWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              AppStrings.noPodcastsFollowSomeUsers.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(
            height: AppHeight.h10,
          ),
          Defaults.defaultButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutesNames.allPodcastsScreen,
                arguments: AllPodcastsScreenParams(
                  servicelocator.get<SearchBloc>(),
                ),
              );
            },
            context: context,
            text: AppStrings.explorePodcasts.tr(),
          )
        ],
      ),
    );
  }
}
