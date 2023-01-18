import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherUserFollowersFollowingWidget extends StatelessWidget {
  const OtherUserFollowersFollowingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherUserProfileBloc, OtherUserProfileState>(
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              // Navigator.of(context).pushNamed(
              //   AppRoutesNames.myProfileFollowersFollowingScreen,
              //   arguments: MyProfileFollowersFollowingScreenParams(
              //       accessToken: ConstVar.accessToken,
              //       isFollowers: true,
              //       userprofileBloc: userProfileBloc),
              // );
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
              // Navigator.of(context).pushNamed(
              //   AppRoutesNames.myProfileFollowersFollowingScreen,
              //   arguments: MyProfileFollowersFollowingScreenParams(
              //       accessToken: ConstVar.accessToken,
              //       isFollowers: false,
              //       userprofileBloc: userProfileBloc),
              // );
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
