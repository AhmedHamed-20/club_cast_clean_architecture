import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/users_card_widget.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/params.dart';

class MainOtherUserFollowersFollowingWidget extends StatelessWidget {
  const MainOtherUserFollowersFollowingWidget({super.key, required this.title});
  final String title;
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
                  itemCount: state.otherUserFollowersFollowingDataEntitie!
                      .otherUserFollowersFollowingUserDataEntitie.length,
                  itemBuilder: (context, index) {
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
                  }),
            ));
      },
    );
  }
}
