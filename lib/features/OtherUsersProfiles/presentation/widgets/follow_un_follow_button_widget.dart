import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowUnFollowButton extends StatelessWidget {
  const FollowUnFollowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherUserProfileBloc, OtherUserProfileState>(
      builder: (context, state) => Defaults.defaultButton(
          onPressed: () {},
          context: context,
          text:
              state.otherUserDataEntitie!.isFollowing ? 'UnFollow' : 'Follow'),
    );
  }
}
