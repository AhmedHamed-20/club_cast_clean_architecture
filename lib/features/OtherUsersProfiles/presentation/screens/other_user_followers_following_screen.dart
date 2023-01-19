import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/error_screen.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';
import '../widgets/main_other_followers_following_widget.dart';

int otherUserFollowersFollowingPage = 2;

ScrollController otherUserFollowersFollowingScrollController =
    ScrollController();
bool isEndOfOtherUserFollowersFollowingData = false;

class OtherUserFollowersFollowingScreen extends StatefulWidget {
  const OtherUserFollowersFollowingScreen(
      {super.key, required this.userId, required this.isFollowers});
  final String userId;
  final bool isFollowers;
  @override
  State<OtherUserFollowersFollowingScreen> createState() =>
      _OtherUserFollowersFollowingScreenState();
}

class _OtherUserFollowersFollowingScreenState
    extends State<OtherUserFollowersFollowingScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getFollowersFollowingData();
    listenToScrollController();
  }

  @override
  void dispose() {
    isEndOfOtherUserFollowersFollowingData = false;
    otherUserFollowersFollowingPage = 2;
    otherUserFollowersFollowingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtherUserProfileBloc, OtherUserProfileState>(
      listener: (context, state) {
        if (widget.isFollowers) {
          isEndOfOtherUserFollowersFollowingData = state.isEndOfFollowersData;
        } else {
          isEndOfOtherUserFollowersFollowingData = state.isEndOfFollowingData;
        }
      },
      builder: (context, state) {
        if (widget.isFollowers) {
          switch (state.followersFollowingDataGetRequestStatus) {
            case FollowersFollowingDataGetRequestStatus.loading:
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            case FollowersFollowingDataGetRequestStatus.success:
              return MainOtherUserFollowersFollowingWidget(
                title: 'Followers',
                isFollowers: true,
                userId: widget.userId,
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
              return MainOtherUserFollowersFollowingWidget(
                title: 'Following',
                isFollowers: false,
                userId: widget.userId,
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

  void getFollowersFollowingData() {
    if (widget.isFollowers) {
      BlocProvider.of<OtherUserProfileBloc>(context).add(
          OtherUserFollowersGetEvent(
              accessToken: ConstVar.accessToken, userId: widget.userId));
    } else {
      BlocProvider.of<OtherUserProfileBloc>(context).add(
          OtherUserFollowingGetEvent(
              accessToken: ConstVar.accessToken, userId: widget.userId));
    }
  }

  void listenToScrollController() {
    otherUserFollowersFollowingScrollController = ScrollController();
    otherUserFollowersFollowingScrollController.addListener(() {
      if (otherUserFollowersFollowingScrollController.position.pixels ==
              otherUserFollowersFollowingScrollController
                  .position.maxScrollExtent &&
          isEndOfOtherUserFollowersFollowingData == false) {
        if (widget.isFollowers) {
          BlocProvider.of<OtherUserProfileBloc>(context).add(
              OtherUserFollowersGetMoreEvent(
                  accessToken: ConstVar.accessToken,
                  userId: widget.userId,
                  page: otherUserFollowersFollowingPage));
          otherUserFollowersFollowingPage++;
        } else {
          BlocProvider.of<OtherUserProfileBloc>(context).add(
              OtherUserFollowingGetMoreEvent(
                  accessToken: ConstVar.accessToken,
                  userId: widget.userId,
                  page: otherUserFollowersFollowingPage));
          otherUserFollowersFollowingPage++;
        }
      }
    });
  }
}
