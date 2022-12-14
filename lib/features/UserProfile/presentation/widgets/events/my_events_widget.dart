import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/core/widgets/events_card_widget.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utl/utls.dart';

class MyEventsWidget extends StatelessWidget {
  const MyEventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userprofileBloc = BlocProvider.of<UserProfileBloc>(context);
    return BlocBuilder<UserProfileBloc, UserprofileState>(
      builder: (context, state) {
        switch (state.myEventRequestStatus) {
          case UserDataGetRequestStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case UserDataGetRequestStatus.success:
            return Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Defaults.defaultTextButton(
                    child: Text(
                      'Create Event',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          AppRoutesNames.createEventScreen,
                          arguments: CreateEventScreenParams(userprofileBloc));
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: state.myEvents.length,
                      itemBuilder: (context, index) => EventsCardWidget(
                          onPressedOnEdit: () {
                            Navigator.of(context).pushNamed(
                              AppRoutesNames.editEventScreen,
                              arguments: EditEventScreenParams(
                                state.myEvents[index],
                                userprofileBloc,
                              ),
                            );
                          },
                          date: state.myEvents[index].eventDate,
                          eventDescription:
                              state.myEvents[index].eventDescription,
                          eventsTitle: state.myEvents[index].eventName)),
                ),
              ],
            );
          case UserDataGetRequestStatus.error:
            return Center(
              child: Text(state.errorMessage),
            );
        }
      },
    );
  }
}
