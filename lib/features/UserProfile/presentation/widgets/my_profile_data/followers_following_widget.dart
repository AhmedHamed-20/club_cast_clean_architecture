import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/routes/app_route_names.dart';

class FollowersFollowingWidget extends StatelessWidget {
  const FollowersFollowingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
    return BlocBuilder<LayoutBloc, LayoutState>(
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutesNames.myProfileFollowersFollowingScreen,
                arguments: MyProfileFollowersFollowingScreenParams(
                    accessToken: ConstVar.accessToken,
                    isFollowers: true,
                    userprofileBloc: userProfileBloc),
              );
            },
            child: Column(
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
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutesNames.myProfileFollowersFollowingScreen,
                arguments: MyProfileFollowersFollowingScreenParams(
                    accessToken: ConstVar.accessToken,
                    isFollowers: false,
                    userprofileBloc: userProfileBloc),
              );
            },
            child: Column(
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
          ),
        ],
      ),
    );
  }
}
