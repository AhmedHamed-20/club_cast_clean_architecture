import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/error_screen.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';
import '../widgets/main_other_followers_following_widget.dart';

class OtherUserFollowersFollowingScreen extends StatefulWidget {
  const OtherUserFollowersFollowingScreen(
      {super.key, required this.userId, required this.isFollwers});
  final String userId;
  final bool isFollwers;
  @override
  State<OtherUserFollowersFollowingScreen> createState() =>
      _OtherUserFollowersFollowingScreenState();
}

class _OtherUserFollowersFollowingScreenState
    extends State<OtherUserFollowersFollowingScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.isFollwers) {
      BlocProvider.of<OtherUserProfileBloc>(context).add(
          OtherUserFollowersGetEvent(
              accessToken: ConstVar.accessToken, userId: widget.userId));
    } else {
      BlocProvider.of<OtherUserProfileBloc>(context).add(
          OtherUserFollowingGetEvent(
              accessToken: ConstVar.accessToken, userId: widget.userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherUserProfileBloc, OtherUserProfileState>(
      builder: (context, state) {
        if (widget.isFollwers) {
          switch (state.followersFollowingDataGetRequestStatus) {
            case FollowersFollowingDataGetRequestStatus.loading:
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            case FollowersFollowingDataGetRequestStatus.success:
              return const MainOtherUserFollowersFollowingWidget(
                title: 'Followers',
              );
            case FollowersFollowingDataGetRequestStatus.error:
              if (state.statusCode == 403 || state.statusCode == 401) {
                return Scaffold(
                  body: ErrorScreen(
                    message: state.errorMessage,
                    statusCode: state.statusCode,
                  ),
                );
              } else {
                return Scaffold(
                  body: ErrorScreen(
                    message: state.errorMessage,
                    onRetry: () {
                      BlocProvider.of<OtherUserProfileBloc>(context).add(
                          OtherUserFollowersGetEvent(
                              accessToken: ConstVar.accessToken,
                              userId: widget.userId));
                    },
                  ),
                );
              }
          }
        } else {
          switch (state.followersFollowingDataGetRequestStatus) {
            case FollowersFollowingDataGetRequestStatus.loading:
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            case FollowersFollowingDataGetRequestStatus.success:
              return const MainOtherUserFollowersFollowingWidget(
                title: 'Following',
              );
            case FollowersFollowingDataGetRequestStatus.error:
              if (state.statusCode == 403 || state.statusCode == 401) {
                return Scaffold(
                  body: ErrorScreen(
                    message: state.errorMessage,
                    statusCode: state.statusCode,
                  ),
                );
              } else {
                return Scaffold(
                  body: ErrorScreen(
                    message: state.errorMessage,
                    onRetry: () {
                      BlocProvider.of<OtherUserProfileBloc>(context).add(
                          OtherUserFollowingGetEvent(
                              accessToken: ConstVar.accessToken,
                              userId: widget.userId));
                    },
                  ),
                );
              }
          }
        }
      },
    );
  }
}
