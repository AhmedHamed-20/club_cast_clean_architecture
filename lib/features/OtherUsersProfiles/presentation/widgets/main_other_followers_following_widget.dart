import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/users_card_widget.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/screens/other_user_followers_following_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/params.dart';

class MainOtherUserFollowersFollowingWidget extends StatelessWidget {
  const MainOtherUserFollowersFollowingWidget(
      {super.key,
      required this.title,
      required this.isFollowers,
      required this.userId});
  final String title;
  final bool isFollowers;
  final String userId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherUserProfileBloc, OtherUserProfileState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                iconTheme: Theme.of(context).iconTheme,
                title: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                )),
            body: Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: ListView.builder(
                  controller: otherUserFollowersFollowingScrollController,
                  itemCount: state.otherUserFollowersFollowingDataEntitie!
                          .otherUserFollowersFollowingUserDataEntitie.length +
                      1,
                  itemBuilder: (context, index) {
                    if (index <
                        state
                            .otherUserFollowersFollowingDataEntitie!
                            .otherUserFollowersFollowingUserDataEntitie
                            .length) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              AppRoutesNames.otherUserProfileScreen,
                              arguments: OtherUserProfileScreenParams(state
                                  .otherUserFollowersFollowingDataEntitie!
                                  .otherUserFollowersFollowingUserDataEntitie[
                                      index]
                                  .uid));
                        },
                        child: UserCardWidget(
                          userName: state
                              .otherUserFollowersFollowingDataEntitie!
                              .otherUserFollowersFollowingUserDataEntitie[index]
                              .name,
                          userPhoto: state
                              .otherUserFollowersFollowingDataEntitie!
                              .otherUserFollowersFollowingUserDataEntitie[index]
                              .profileImage,
                        ),
                      );
                    } else {
                      return Center(
                        child: isEndOfOtherUserFollowersFollowingData
                            ? const SizedBox.shrink()
                            : const Center(
                                child: Padding(
                                padding: EdgeInsets.all(AppPadding.p8),
                                child: CircularProgressIndicator(),
                              )),
                      );
                    }
                  }),
            ));
      },
    );
  }
}
