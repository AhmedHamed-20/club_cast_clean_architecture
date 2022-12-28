import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowersFollowingWidget extends StatelessWidget {
  const FollowersFollowingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutBloc, LayoutState>(
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Column(
          //   children: [
          //     Text(
          //       state.userDataEntitie!.followers.toString(),
          //       style: Theme.of(context).textTheme.titleMedium,
          //     ),
          //     Text(
          //       'Podcasts',
          //       style: Theme.of(context).textTheme.titleLarge,
          //     ),
          //   ],
          // ),
          Column(
            children: [
              Text(
                state.userDataEntitie!.followers.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Followers',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                state.userDataEntitie!.following.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Following',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
