import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/widgets/user_profile_app_bar_icons.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/widgets/CreateRoomBottomSheetWidgets/create_room_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_to_background/move_to_background.dart';

import '../../../constants/constants.dart';
import '../../../constants/media_query_of_methods.dart';
import 'bottom_sheet_widget.dart';

class MainLayoutWidget extends StatelessWidget {
  const MainLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final layoutBloc = BlocProvider.of<LayoutBloc>(context);
    return BlocBuilder<LayoutBloc, LayoutState>(builder: (context, state) {
      return WillPopScope(
        onWillPop: () async => willPopScope(layoutBloc, state),
        child: Scaffold(
          bottomSheet: MainLayoutBottomSheetWidget(
            layoutBottomSheetStatus: state.layoutBottomSheetStatus,
          ),
          appBar: AppBar(
            leading: const SizedBox(),
            centerTitle: true,
            title: Text(
              layoutBloc.appBarTitles[state.currentBottomNavIndex],
              style: Theme.of(context).textTheme.titleLarge,
            ),
            actions: [
              state.currentBottomNavIndex == 4
                  ? const UserProfileAppBarIconsWidget()
                  : const SizedBox.shrink(),
            ],
          ),
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: Theme.of(context).colorScheme.background,
              height: MediaQueryOfMethods.getAppHeight(context) * 0.08,
              elevation: AppElevation.eL6,
              indicatorColor: state.currentBottomNavIndex == 4
                  ? AppColors.transparentColor
                  : Theme.of(context).primaryColor.withOpacity(0.5),
              iconTheme: MaterialStateProperty.all(
                Theme.of(context).iconTheme.copyWith(size: 20),
              ),
            ),
            child: NavigationBar(
              surfaceTintColor: Theme.of(context).primaryColor,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              elevation: AppElevation.eL4,
              destinations: layoutBloc.bottomNaveIcons(
                  photoUrl: state.userDataEntitie!.userPhoto, phototRadius: 35),
              backgroundColor: Theme.of(context).colorScheme.background,
              selectedIndex: state.currentBottomNavIndex,
              onDestinationSelected: (value) {
                if (value == 2) {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context,
                      builder: (context) => const CreateRoomBottomSheet());
                  return;
                }
                layoutBloc.add(
                  BottomNavIndexChangeEvent(value),
                );
              },
            ),
          ),
          body: layoutBloc.bottomNaveScreens[state.currentBottomNavIndex],
        ),
      );
    });
  }

  Future<bool> willPopScope(LayoutBloc layoutBloc, LayoutState state) async {
    if (state.currentBottomNavIndex == 0) {
      await MoveToBackground.moveTaskToBack();
      return false;
    } else {
      layoutBloc.add(const BottomNavIndexChangeEvent(0));
      return false;
    }
  }
}
