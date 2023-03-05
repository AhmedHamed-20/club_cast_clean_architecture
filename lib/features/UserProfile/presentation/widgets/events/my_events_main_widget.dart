// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/MyEventsBloc/my_events_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/params.dart';
import '../../../../../core/routes/app_route_names.dart';
import '../../../../../core/widgets/events_card_widget.dart';

class MyEventsMainWidget extends StatefulWidget {
  const MyEventsMainWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MyEventsMainWidget> createState() => _MyEventsMainWidgetState();
}

class _MyEventsMainWidgetState extends State<MyEventsMainWidget> {
  late ScrollController myEventsScrollController;
  bool isEndOfMyEventsData = false;
  int myEventsPage = 2;
  @override
  void initState() {
    super.initState();
    addEventsListener();
  }

  @override
  void dispose() {
    disposeScrollEventsController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myEventsBloc = BlocProvider.of<MyEventsBloc>(context);
    return Expanded(
      child: BlocConsumer<MyEventsBloc, MyEventsState>(
        listener: (context, state) {
          isEndOfMyEventsData = state.isEndOfMyEventsData;
        },
        builder: (context, state) => RefreshIndicator(
          onRefresh: () async {
            myEventsBloc.add(
                MyEventsGetEvent(accessToken: ConstVar.accessToken, page: 1));
          },
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: myEventsScrollController,
              itemCount: state.myEvents.myEventsDataEntitie.length + 1,
              itemBuilder: (context, index) {
                if (index < state.myEvents.myEventsDataEntitie.length) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: index ==
                                state.myEvents.myEventsDataEntitie.length - 1
                            ? AppPadding.p60
                            : 0),
                    child: EventsCardWidget(
                      isHomeScreen: false,
                      isMyProfile: true,
                      onPressedOnEdit: () {
                        Navigator.of(context).pushNamed(
                          AppRoutesNames.editEventScreen,
                          arguments: EditEventScreenParams(
                            state.myEvents.myEventsDataEntitie[index],
                            myEventsBloc,
                          ),
                        );
                      },
                      eventEntitie: state.myEvents.myEventsDataEntitie[index],
                    ),
                  );
                } else {
                  return state.isEndOfMyEventsData
                      ? const SizedBox.shrink()
                      : const Padding(
                          padding: EdgeInsets.all(AppPadding.p8),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                }
              }),
        ),
      ),
    );
  }

  void addEventsListener() {
    final myEventsBloc = BlocProvider.of<MyEventsBloc>(context);
    myEventsScrollController = ScrollController();
    myEventsScrollController.addListener(() {
      if (myEventsScrollController.position.pixels ==
              myEventsScrollController.position.maxScrollExtent &&
          isEndOfMyEventsData == false) {
        myEventsBloc.add(
          MyEventsGetMoreEvent(
            accessToken: ConstVar.accessToken,
            page: myEventsPage,
          ),
        );
        myEventsPage++;
      }
    });
  }

  void disposeScrollEventsController() {
    myEventsScrollController.dispose();
    myEventsPage = 2;
    isEndOfMyEventsData = false;
  }
}
