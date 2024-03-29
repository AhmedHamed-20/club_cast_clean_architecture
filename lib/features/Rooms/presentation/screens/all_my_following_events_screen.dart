import 'dart:math';

import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/core/widgets/events_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/LocalNotification/local_notification_helper.dart';
import '../../../../core/constants/params.dart';
import '../../../../core/routes/app_route_names.dart';

bool isEndOfMyFollowingEventsData = false;
int myFollowingEventsPage = 2;

class AllMyFollowingEventsScreen extends StatefulWidget {
  const AllMyFollowingEventsScreen({
    super.key,
  });

  @override
  State<AllMyFollowingEventsScreen> createState() =>
      _AllMyFollowingEventsScreenState();
}

class _AllMyFollowingEventsScreenState
    extends State<AllMyFollowingEventsScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    disposeScrollController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.allMyFollowingEvents.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child:
              BlocBuilder<LayoutBloc, LayoutState>(builder: (context, state) {
            return ListView.builder(
                itemCount: state.myFollowingEventsEntitie!
                    .myFollowingEventsDataEntity.length,
                controller: scrollController,
                itemBuilder: (context, index) {
                  if (index <=
                      state.myFollowingEventsEntitie!
                          .myFollowingEventsDataEntity.length) {
                    return EventsCardWidget(
                      onPressedOnNotification: () async {
                        String eventDate = state.myFollowingEventsEntitie!
                            .myFollowingEventsDataEntity[index].eventDate;
                        Duration diffrence = DateTime.parse(eventDate)
                            .difference(DateTime.now());
                        await LocalNotificationHelper.scheduleNotification(
                          title: state.myFollowingEventsEntitie!
                              .myFollowingEventsDataEntity[index].eventName,
                          body: state
                              .myFollowingEventsEntitie!
                              .myFollowingEventsDataEntity[index]
                              .eventDescription,
                          index: Random().nextInt(200),
                          eventTime: DateTime.now().add(diffrence),
                        );
                      },
                      isHomeScreen: false,
                      onPressedOnUserPhoto: () {
                        Navigator.of(context).pushNamed(
                          AppRoutesNames.otherUserProfileScreen,
                          arguments: OtherUserProfileScreenParams(
                            state
                                .myFollowingEventsEntitie!
                                .myFollowingEventsDataEntity[index]
                                .userInfo
                                .uid,
                          ),
                        );
                      },
                      eventEntitie: state.myFollowingEventsEntitie!
                          .myFollowingEventsDataEntity[index],
                      isMyProfile: false,
                      eventUserName: state.myFollowingEventsEntitie!
                          .myFollowingEventsDataEntity[index].userInfo.userName,
                      eventUserPhoto: state
                          .myFollowingEventsEntitie!
                          .myFollowingEventsDataEntity[index]
                          .userInfo
                          .userPhoto,
                      onPressedOnEdit: () {},
                    );
                  } else {
                    return state.isEndOfEvents
                        ? const SizedBox.shrink()
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  }
                });
          })),
    );
  }

  void listenToScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          isEndOfMyFollowingEventsData == false) {
        BlocProvider.of<LayoutBloc>(context).add(MyFollowingEventsGetMoreEvent(
            ConstVar.accessToken, myFollowingEventsPage));
        myFollowingEventsPage++;
      }
    });
  }

  void disposeScrollController() {
    scrollController.dispose();
    myFollowingEventsPage = 2;
  }
}
