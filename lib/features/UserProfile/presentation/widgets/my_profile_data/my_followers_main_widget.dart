import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/routes/app_route_names.dart';
import '../../../../../core/widgets/users_card_widget.dart';

int myFollowersPage = 2;
bool isEndOfMyFollowersData = false;

class MyFollowersMainWidget extends StatefulWidget {
  const MyFollowersMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MyFollowersMainWidget> createState() => _MyFollowersMainWidgetState();
}

class _MyFollowersMainWidgetState extends State<MyFollowersMainWidget> {
  late ScrollController myFollowersScrollerController;
  @override
  void initState() {
    super.initState();
    initMyFollowersScrollController();
  }

  @override
  void dispose() {
    disposeMyFollowersScrollController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          'Followers',
          style: Theme.of(context).textTheme.titleLarge,
          
        ),
      ),
      body: BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          isEndOfMyFollowersData = state.isEndOfFollowersData;
        },
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: ListView.builder(
              controller: myFollowersScrollerController,
              itemCount:
                  state.followersData!.followerFollowigDataEntite.length + 1,
              itemBuilder: (context, index) {
                if (index <
                    state.followersData!.followerFollowigDataEntite.length) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          AppRoutesNames.otherUserProfileScreen,
                          arguments: OtherUserProfileScreenParams(state
                              .followersData!
                              .followerFollowigDataEntite[index]
                              .userId));
                    },
                    child: UserCardWidget(
                      userName: state.followersData!
                          .followerFollowigDataEntite[index].userName,
                      userPhoto: state.followersData!
                          .followerFollowigDataEntite[index].userPhoto,
                    ),
                  );
                } else {
                  return state.isEndOfFollowersData
                      ? const SizedBox.shrink()
                      : const Padding(
                          padding: EdgeInsets.all(AppPadding.p6),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                }
              }),
        ),
      ),
    );
  }

  void initMyFollowersScrollController() {
    final userProfileBLoc = BlocProvider.of<UserProfileBloc>(context);
    myFollowersScrollerController = ScrollController();
    myFollowersScrollerController.addListener(() {
      if (myFollowersScrollerController.position.pixels ==
              myFollowersScrollerController.position.maxScrollExtent &&
          isEndOfMyFollowersData == false) {
        userProfileBLoc.add(
          MyFollowersGetMoreEvent(
            ConstVar.accessToken,
            myFollowersPage,
          ),
        );
        myFollowersPage++;
      }
    });
  }

  void disposeMyFollowersScrollController() {
    myFollowersPage = 2;
    isEndOfMyFollowersData = false;
    myFollowersScrollerController.dispose();
  }
}
