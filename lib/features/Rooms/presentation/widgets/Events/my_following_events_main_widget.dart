import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/core/widgets/events_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';

bool isEndOfMyFollowingEventsData = false;
int myFollowingEventsPage = 2;

class MyFollowingEventsMainWidget extends StatefulWidget {
  const MyFollowingEventsMainWidget({super.key});

  @override
  State<MyFollowingEventsMainWidget> createState() =>
      _MyFollowingEventsMainWidgetState();
}

class _MyFollowingEventsMainWidgetState
    extends State<MyFollowingEventsMainWidget> {
  ScrollController scrollController = ScrollController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listenToScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    myFollowingEventsPage = 2;
    isEndOfMyFollowingEventsData = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutBloc, LayoutState>(listener: (context, state) {
      isEndOfMyFollowingEventsData = state.isEndOfEvents;
    }, builder: (context, state) {
      return SizedBox(
        height: MediaQueryOfMethods.getAppHeight(context) * 0.25,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            itemCount: state.myFollowingEventsEntitie!
                    .myFollowingEventsDataEntitie.length +
                1,
            itemBuilder: (context, index) {
              if (index <
                  state.myFollowingEventsEntitie!.myFollowingEventsDataEntitie
                      .length) {
                return SizedBox(
                  width: MediaQueryOfMethods.getAppWidth(context),
                  child: EventsCardWidget(
                    eventUserName: state.myFollowingEventsEntitie!
                        .myFollowingEventsDataEntitie[index].userInfo.userName,
                    eventUserPhoto: state.myFollowingEventsEntitie!
                        .myFollowingEventsDataEntitie[index].userInfo.userPhoto,
                    date: state.myFollowingEventsEntitie!
                        .myFollowingEventsDataEntitie[index].eventDate,
                    eventDescription: state.myFollowingEventsEntitie!
                        .myFollowingEventsDataEntitie[index].eventDescription,
                    eventsTitle: state.myFollowingEventsEntitie!
                        .myFollowingEventsDataEntitie[index].eventName,
                    isMyProfile: false,
                  ),
                );
              } else {
                return state.isEndOfEvents
                    ? const SizedBox.shrink()
                    : const Padding(
                        padding: EdgeInsets.all(AppPadding.p8),
                        child: Center(child: CircularProgressIndicator()),
                      );
              }
            }),
      );
    });
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
}
