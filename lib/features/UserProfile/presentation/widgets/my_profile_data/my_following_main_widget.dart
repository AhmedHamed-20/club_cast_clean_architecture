import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/params.dart';
import '../../../../../core/routes/app_route_names.dart';
import '../../../../../core/widgets/users_card_widget.dart';

int myFollowingPage = 2;
bool isEndOfMyFolloweringData = false;

class MyFollowingMainWidget extends StatefulWidget {
  const MyFollowingMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MyFollowingMainWidget> createState() => _MyFollowingMainWidgetState();
}

class _MyFollowingMainWidgetState extends State<MyFollowingMainWidget> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          isEndOfMyFolloweringData == false) {
        BlocProvider.of<UserProfileBloc>(context).add(
          MyFollowingGetMoreEvent(
            ConstVar.accessToken,
            myFollowingPage,
          ),
        );
        myFollowingPage++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          'Following',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          isEndOfMyFolloweringData = state.isEndOfFollowingData;
        },
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: ListView.builder(
              controller: scrollController,
              itemCount:
                  state.followingData!.followerFollowigDataEntite.length + 1,
              itemBuilder: (context, index) {
                if (index <
                    state.followingData!.followerFollowigDataEntite.length) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          AppRoutesNames.otherUserProfileScreen,
                          arguments: OtherUserProfileScreenParams(state
                              .followingData!
                              .followerFollowigDataEntite[index]
                              .userId));
                    },
                    child: UserCardWidget(
                      userName: state.followingData!
                          .followerFollowigDataEntite[index].userName,
                      userPhoto: state.followingData!
                          .followerFollowigDataEntite[index].userPhoto,
                    ),
                  );
                } else {
                  return state.isEndOfFollowingData
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
}
