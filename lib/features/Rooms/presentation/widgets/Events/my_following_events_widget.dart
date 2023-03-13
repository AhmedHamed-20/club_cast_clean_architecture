import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/layout/presentation/bloc/layout_bloc.dart';
import '../../../../../core/utl/utls.dart';
import '../../../../../core/widgets/error_screen.dart';
import 'my_following_events_main_widget.dart';

class MyFollowingEventsWidget extends StatelessWidget {
  const MyFollowingEventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutBloc, LayoutState>(
      builder: (context, state) {
        switch (state.myFollowingEventsRequestStatus) {
          case UserDataGetRequestStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case UserDataGetRequestStatus.success:
            if (state.myFollowingEventsEntitie!.myFollowingEventsDataEntitie
                .isEmpty) {
              return SizedBox(
                height: MediaQueryOfMethods.getAppHeight(context) * 0.1,
                child: Center(
                    child: Text(
                  AppStrings.noEvents.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                )),
              );
            } else {
              return const MyFollowingEventsMainWidget();
            }
          case UserDataGetRequestStatus.error:
            if (state.statusCode == 403 || state.statusCode == 401) {
              return ErrorScreen(
                isHoleScreen: false,
                message: state.errorMessage,
                statusCode: state.statusCode,
              );
            } else {
              return ErrorScreen(
                isHoleScreen: false,
                message: state.errorMessage,
                onRetry: () {
                  BlocProvider.of<LayoutBloc>(context).add(
                    MyFollowingEventsGetEvent(ConstVar.accessToken),
                  );
                },
              );
            }
        }
      },
    );
  }
}
