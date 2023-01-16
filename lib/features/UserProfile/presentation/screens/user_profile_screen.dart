import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/core/services/service_locator.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/my_profile_data/main_user_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutBloc, LayoutState>(
      builder: (context, layoutState) => BlocProvider(
        create: (context) => servicelocator<UserProfileBloc>()
          ..add(
            BackGroundColorGenerateEvent(
              layoutState.userDataEntitie!.userPhoto,
            ),
          )
          ..add(
            MyPodcastsGetEvent(
              ConstVar.accessToken,
            ),
          )
          ..add(MyEventsGetEvent(ConstVar.accessToken)),
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, state) {
          switch (state.backGroundColorGenerateRequestStatus) {
            case BackGroundColorGenerateRequestStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case BackGroundColorGenerateRequestStatus.generated:
              return const MainUserProfileWidget();
            case BackGroundColorGenerateRequestStatus.error:
              return const MainUserProfileWidget();
          }
        }),
      ),
    );
  }
}
