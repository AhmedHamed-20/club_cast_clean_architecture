import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';

class OtherUserFollowersFollowingWidget extends StatelessWidget {
  const OtherUserFollowersFollowingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OtherUserProfileBloc otherUserProfileBloc =
        BlocProvider.of<OtherUserProfileBloc>(context);
    return BlocBuilder<OtherUserProfileBloc, OtherUserProfileState>(
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutesNames.otherUserFollowersFollowingScreen,
                arguments: OtherUserFollowersFollowingScreenParams(
                  isFollwers: true,
                  otherUserProfileBloc: otherUserProfileBloc,
                  userId: state.otherUserDataEntitie!.uid.toString(),
                ),
              );
            },
            child: Column(
              children: [
                Text(
                  state.otherUserDataEntitie!.followers.toString(),
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
                AppRoutesNames.otherUserFollowersFollowingScreen,
                arguments: OtherUserFollowersFollowingScreenParams(
                  isFollwers: false,
                  otherUserProfileBloc: otherUserProfileBloc,
                  userId: state.otherUserDataEntitie!.uid.toString(),
                ),
              );
            },
            child: Column(
              children: [
                Text(
                  state.otherUserDataEntitie!.following.toString(),
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
