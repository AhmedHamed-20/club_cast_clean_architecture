import 'dart:math';

import 'package:club_cast_clean_architecture/core/LocalNotification/local_notification_helper.dart';
import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/core/routes/app_route_names.dart';
import 'package:club_cast_clean_architecture/core/widgets/events_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyFollowingEventsMainWidget extends StatelessWidget {
  const MyFollowingEventsMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutBloc, LayoutState>(builder: (context, state) {
      return SizedBox(
        height: MediaQueryOfMethods.getAppHeight(context) * 0.25,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.myFollowingEventsEntitie!
                        .myFollowingEventsDataEntitie.length <=
                    5
                ? state.myFollowingEventsEntitie!.myFollowingEventsDataEntitie
                    .length
                : 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutesNames.allMyFollowingEventsScreen);
                },
                child: SizedBox(
                  width: MediaQueryOfMethods.getAppWidth(context),
                  child: EventsCardWidget(
                    onPressedOnNotification: () async {
                      String eventDate = state.myFollowingEventsEntitie!
                          .myFollowingEventsDataEntitie[index].eventDate;
                      Duration diffrence =
                          DateTime.parse(eventDate).difference(DateTime.now());
                      await LocalNotificationHelper.scheduleNotification(
                        title: state.myFollowingEventsEntitie!
                            .myFollowingEventsDataEntitie[index].eventName,
                        body: state
                            .myFollowingEventsEntitie!
                            .myFollowingEventsDataEntitie[index]
                            .eventDescription,
                        index: Random().nextInt(200),
                        eventTime: DateTime.now().add(diffrence),
                      );
                    },
                    isHomeScreen: true,
                    onPressedOnUserPhoto: () {
                      Navigator.of(context).pushNamed(
                          AppRoutesNames.otherUserProfileScreen,
                          arguments: OtherUserProfileScreenParams(state
                              .myFollowingEventsEntitie!
                              .myFollowingEventsDataEntitie[index]
                              .userInfo
                              .uid));
                    },
                    eventUserName: state.myFollowingEventsEntitie!
                        .myFollowingEventsDataEntitie[index].userInfo.userName,
                    eventUserPhoto: state.myFollowingEventsEntitie!
                        .myFollowingEventsDataEntitie[index].userInfo.userPhoto,
                    eventEntitie: state.myFollowingEventsEntitie!
                        .myFollowingEventsDataEntitie[index],
                    isMyProfile: false,
                  ),
                ),
              );
            }),
      );
    });
  }
}
