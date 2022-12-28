import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/user_data_entitie.dart';
import 'package:club_cast_clean_architecture/core/services/service_locator.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/main_user_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key, required this.userDataEntitie});
  final UserDataEntitie userDataEntitie;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => servicelocator<UserprofileBloc>()
        ..add(
          BackGroundColorGenerateEvent(
            userDataEntitie.userPhoto,
          ),
        )
        ..add(
          MyPodcastsGetEvent(
            ConstVar.accessToken,
          ),
        )
        ..add(MyEventsGetEvent(ConstVar.accessToken)),
      child: BlocBuilder<UserprofileBloc, UserprofileState>(
          builder: (context, state) {
        switch (state.backGroundColorGenerateRequestStatus) {
          case BackGroundColorGenerateRequestStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case BackGroundColorGenerateRequestStatus.generated:
            return MainUserProfileWidget(userDataEntitie: userDataEntitie);
          case BackGroundColorGenerateRequestStatus.error:
            return MainUserProfileWidget(userDataEntitie: userDataEntitie);
        }
      }),
    );
  }
}
