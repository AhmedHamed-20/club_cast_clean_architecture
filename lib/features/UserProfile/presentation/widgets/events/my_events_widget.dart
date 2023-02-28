import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/MyEventsBloc/my_events_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/routes/app_route_names.dart';
import '../../../../../core/utl/utls.dart';
import '../../../../../core/widgets/error_screen.dart';
import 'my_events_main_widget.dart';

class MyEventsWidget extends StatelessWidget {
  const MyEventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final myEventsBloc = BlocProvider.of<MyEventsBloc>(context);
    return BlocBuilder<MyEventsBloc, MyEventsState>(
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
                  alignment: state.myEvents.myEventsDataEntitie.isEmpty
                      ? AlignmentDirectional.center
                      : AlignmentDirectional.centerEnd,
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
                          arguments: CreateEventScreenParams(myEventsBloc));
                    },
                  ),
                ),
                const MyEventsMainWidget(),
              ],
            );
          case UserDataGetRequestStatus.error:
            if (state.statusCode == 403 || state.statusCode == 401) {
              return ErrorScreen(
                isHoleScreen: true,
                message: state.errorMessages,
                statusCode: state.statusCode,
              );
            } else {
              return ErrorScreen(
                isHoleScreen: true,
                message: state.errorMessages,
                onRetry: () {
                  myEventsBloc.add(
                    MyEventsGetEvent(
                        accessToken: ConstVar.accessToken, page: 1),
                  );
                },
              );
            }
        }
      },
    );
  }
}
