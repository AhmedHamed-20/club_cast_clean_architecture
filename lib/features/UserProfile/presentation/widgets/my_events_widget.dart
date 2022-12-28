import 'package:club_cast_clean_architecture/core/widgets/events_card_widget.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utl/utls.dart';

class MyEventsWidget extends StatelessWidget {
  const MyEventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserprofileBloc, UserprofileState>(
      builder: (context, state) {
        switch (state.myEventRequestStatus) {
          case UserDataGetRequestStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case UserDataGetRequestStatus.success:
            return ListView.builder(
                itemCount: state.myEvents.length,
                itemBuilder: (context, index) => EventsCardWidget(
                    onPressedOnEdit: () {},
                    date: state.myEvents[index].eventDate,
                    eventDescription: state.myEvents[index].eventDescription,
                    eventsTitle: state.myEvents[index].eventName));
          case UserDataGetRequestStatus.error:
            return Center(
              child: Text(state.errorMessage),
            );
        }
      },
    );
  }
}
