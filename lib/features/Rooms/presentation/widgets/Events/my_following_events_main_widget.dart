import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
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
                    isHomeScreen: true,
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
