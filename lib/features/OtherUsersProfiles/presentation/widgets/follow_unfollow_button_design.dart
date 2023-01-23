import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/defaults.dart';
import '../bloc/otherusersprofiles_bloc.dart';

class FollowUnfollowButtonDesign extends StatelessWidget {
  const FollowUnfollowButtonDesign({super.key, required this.state});
  final OtherUserProfileState state;
  @override
  Widget build(BuildContext context) {
    return Defaults.defaultButton(
        onPressed: () {
          if (state.isFollowed) {
            BlocProvider.of<OtherUserProfileBloc>(context).add(
              UnFollowUserEvent(
                accessToken: ConstVar.accessToken,
                userId: state.otherUserDataEntitie!.uid,
              ),
            );
          } else {
            BlocProvider.of<OtherUserProfileBloc>(context).add(
              FollowUserEvent(
                accessToken: ConstVar.accessToken,
                userId: state.otherUserDataEntitie!.uid,
              ),
            );
          }
        },
        context: context,
        text: state.isFollowed ? 'UnFollow' : 'Follow');
  }
}