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
                'Users',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Tab(
              child: Text(
                'Rooms',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Tab(
              child: Text(
                'Podcasts',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
