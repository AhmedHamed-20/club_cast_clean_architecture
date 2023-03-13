import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../screens/search_screen.dart';

class SearchAppBarWidget extends StatelessWidget {
  const SearchAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AppBar(
        leading: const SizedBox.shrink(),
        bottom: TabBar(
          controller: searchTabController,
          indicatorColor: Theme.of(context).primaryColor,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(
              child: Text(
                AppStrings.users.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Tab(
              child: Text(
                AppStrings.rooms.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Tab(
              child: Text(
                AppStrings.podcasts.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
