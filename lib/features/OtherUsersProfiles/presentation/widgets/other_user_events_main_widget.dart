import 'dart:math';

import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/events_card_widget.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/domain/entities/other_user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/LocalNotification/local_notification_helper.dart';
import '../bloc/otherusersprofiles_bloc.dart';

bool isEndOfData = false;
int otherUserEventsPage = 2;

class OtherUserEventsMainWidget extends StatefulWidget {
  const OtherUserEventsMainWidget(
      {super.key, required this.otherUserEventsEntitie, required this.userId});
  final OtherUserEventsEntity otherUserEventsEntitie;
  final String userId;
  @override
  State<OtherUserEventsMainWidget> createState() =>
      _OtherUserEventsMainWidgetState();
}

class _OtherUserEventsMainWidgetState extends State<OtherUserEventsMainWidget> {
  late ScrollController scrollController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listenToScrollController();
  }

  @override
  void dispose() {
    disposeOtherEventsController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otherUserProfileBloc = BlocProvider.of<OtherUserProfileBloc>(context);
    return BlocListener<OtherUserProfileBloc, OtherUserProfileState>(
      listener: (context, state) {
        isEndOfData = state.isEndOfEventsData;
      },
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: RefreshIndicator(
          onRefresh: () async {
            otherUserProfileBloc.add(OtherUserEventsGetEvent(
                accessToken: ConstVar.accessToken, userId: widget.userId));
          },
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              itemCount: widget.otherUserEventsEntitie.events.length + 1,
              itemBuilder: (context, index) {
                if (index < widget.otherUserEventsEntitie.events.length) {
                  return EventsCardWidget(
                    onPressedOnNotification: () async {
                      String eventDate =
                          widget.otherUserEventsEntitie.events[index].eventDate;
                      Duration diffrence =
                          DateTime.parse(eventDate).difference(DateTime.now());
                      await LocalNotificationHelper.scheduleNotification(
                        title: widget
                            .otherUserEventsEntitie.events[index].eventName,
                        body: widget.otherUserEventsEntitie.events[index]
                            .eventDescription,
                        index: Random().nextInt(200),
                        eventTime: DateTime.now().add(diffrence),
                      );
                    },
                    isHomeScreen: false,
                    isMyProfile: false,
                    eventEntitie: widget.otherUserEventsEntitie.events[index],
                  );
                } else {
                  return BlocBuilder<OtherUserProfileBloc,
                      OtherUserProfileState>(builder: (context, state) {
                    if (state.isEndOfEventsData == false) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const SizedBox.shrink();
                    }
                  });
                }
              }),
        ),
      ),
    );
  }

  void listenToScrollController() {
    final otherUserProfileBloc = BlocProvider.of<OtherUserProfileBloc>(context);
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          isEndOfData == false) {
        otherUserProfileBloc.add(OtherUserEventsGetMoreEvent(
            accessToken: ConstVar.accessToken,
            userId: widget.userId,
            page: otherUserEventsPage));
        otherUserEventsPage++;
      }
    });
  }

  void disposeOtherEventsController() {
    scrollController.dispose();
    isEndOfData = false;
    otherUserEventsPage = 2;
  }
}
