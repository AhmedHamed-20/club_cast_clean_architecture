import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/params.dart';
import '../../../../core/utl/utls.dart';
import '../widgets/my_followers_main_widget.dart';
import '../widgets/my_following_main_widget.dart';

class FollowersFollowingScreen extends StatefulWidget {
  const FollowersFollowingScreen(
      {super.key, required this.myProfileFollowersFollowingScreenParams});
  final MyProfileFollowersFollowingScreenParams
      myProfileFollowersFollowingScreenParams;
  @override
  State<FollowersFollowingScreen> createState() =>
      _FollowersFollowingScreenState();
}

class _FollowersFollowingScreenState extends State<FollowersFollowingScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.myProfileFollowersFollowingScreenParams.isFollowers) {
      widget.myProfileFollowersFollowingScreenParams.userprofileBloc.add(
          MyFollowersGetEvent(
              widget.myProfileFollowersFollowingScreenParams.accessToken));
    } else {
      widget.myProfileFollowersFollowingScreenParams.userprofileBloc.add(
          MyFollowingGetEvent(
              widget.myProfileFollowersFollowingScreenParams.accessToken));
    }
  }

  @override
  void dispose() {
    myFollowersPage = 2;
    myFollowingPage = 2;
    isEndOfMyFollowersData = false;
    isEndOfMyFolloweringData = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserprofileState>(
        builder: (context, state) {
      if (widget.myProfileFollowersFollowingScreenParams.isFollowers) {
        switch (state.getMyFollowersRequestStatus) {
          case UserDataGetRequestStatus.loading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case UserDataGetRequestStatus.success:
            return const MyFollowersMainWidget();
          case UserDataGetRequestStatus.error:
            return Scaffold(
              body: Center(
                child: Text(state.errorMessage),
              ),
            );
        }
      } else {
        switch (state.getMyFollowingRequestStatus) {
          case UserDataGetRequestStatus.loading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case UserDataGetRequestStatus.success:
            return const MyFollowingMainWidget();
          case UserDataGetRequestStatus.error:
            return Scaffold(
              body: Center(
                child: Text(state.errorMessage),
              ),
            );
        }
      }
    });
  }
}
