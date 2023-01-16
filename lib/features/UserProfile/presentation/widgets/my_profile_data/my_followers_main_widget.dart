import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
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
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          isEndOfMyFollowersData == false) {
        BlocProvider.of<UserProfileBloc>(context).add(
          MyFollowersGetMoreEvent(
            ConstVar.accessToken,
            myFollowersPage.toString(),
          ),
        );
        myFollowersPage++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
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
              controller: scrollController,
              itemCount:
                  state.followersData!.followerFollowigDataEntite.length + 1,
              itemBuilder: (context, index) {
                if (index <
                    state.followersData!.followerFollowigDataEntite.length) {
                  return UserCardWidget(
                    userName: state.followersData!
                        .followerFollowigDataEntite[index].userName,
                    userPhoto: state.followersData!
                        .followerFollowigDataEntite[index].userPhoto,
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
}
