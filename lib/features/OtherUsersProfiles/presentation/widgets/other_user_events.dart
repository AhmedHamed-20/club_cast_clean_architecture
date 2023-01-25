import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';
import '../../../../core/widgets/error_screen.dart';
import 'other_user_events_main_widget.dart';

class OtherUserEventsWidget extends StatelessWidget {
  const OtherUserEventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherUserProfileBloc, OtherUserProfileState>(
        builder: (context, state) {
      switch (state.otherUserEventsGetRequestStatus) {
        case UserDataGetRequestStatus.loading:
          return const Center(child: CircularProgressIndicator());
        case UserDataGetRequestStatus.success:
          if (state.otherUserEventsEntitie!.events.isEmpty) {
            return Center(
                child: Text(
              'No Events TO Show',
              style: Theme.of(context).textTheme.titleLarge,
            ));
          } else {
            return OtherUserEventsMainWidget(
              otherUserEventsEntitie: state.otherUserEventsEntitie!,
              userId: state.otherUserDataEntitie!.uid,
            );
          }
        case UserDataGetRequestStatus.error:
          if (state.statusCode == 401 || state.statusCode == 403) {
            return ErrorScreen(
              message: state.errorMessage,
              statusCode: state.statusCode,
            );
          } else {
            return ErrorScreen(
              message: state.errorMessage,
              onRetry: () {
                BlocProvider.of<OtherUserProfileBloc>(context).add(
                    OtherUserProfileGetEvent(
                        accessToken: ConstVar.accessToken,
                        userId: state.otherUserDataEntitie!.uid));
              },
            );
          }
      }
    });
  }
}