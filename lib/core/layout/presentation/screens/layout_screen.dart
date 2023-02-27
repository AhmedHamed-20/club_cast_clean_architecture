import 'package:club_cast_clean_architecture/core/LocalNotification/local_notification_helper.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/core/widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utl/utls.dart';
import '../widgets/main_layout_widget.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    super.initState();
    userDataGet();
    initLocalNotification();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutBloc, LayoutState>(builder: (context, state) {
      switch (state.userDataGetRequestStatus) {
        case UserDataGetRequestStatus.loading:
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        case UserDataGetRequestStatus.success:
          BlocProvider.of<LayoutBloc>(context).add(const CategoriesGetEvent());
          return const MainLayoutWidget();
        case UserDataGetRequestStatus.error:
          if (state.statusCode == 403 || state.statusCode == 401) {
            return Scaffold(
              body: ErrorScreen(
                message: state.errorMessage,
                statusCode: state.statusCode,
              ),
            );
          } else {
            return Scaffold(
              body: ErrorScreen(
                message: state.errorMessage,
                onRetry: () {
                  BlocProvider.of<LayoutBloc>(context)
                      .add(ActiveUserDataGetEvent(ConstVar.accessToken));
                },
              ),
            );
          }
      }
    });
  }

  void userDataGet() {
    BlocProvider.of<LayoutBloc>(context)
      ..add(
        ActiveUserDataGetEvent(ConstVar.accessToken),
      )
      ..add(MyFollowingEventsGetEvent(ConstVar.accessToken));
  }

  void initLocalNotification() async {
    await LocalNotificationHelper.init();
  }
}
