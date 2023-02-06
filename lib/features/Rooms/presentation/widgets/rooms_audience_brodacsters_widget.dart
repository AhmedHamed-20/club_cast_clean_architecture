import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';

import 'audience_widget.dart';
import 'broadcasters_widget.dart';

class RoomsAudienceBrodcastersWidget extends StatelessWidget {
  const RoomsAudienceBrodcastersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Center(
              child: Text(
                'Broadcasters',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: AppHeight.h10,
            ),
          ),
          const BroadcastersWidget(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: AppHeight.h10,
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Text(
                'Audience',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: AppHeight.h10,
            ),
          ),
          const AudienceWidget(),
        ],
      ),
    );
  }
}
