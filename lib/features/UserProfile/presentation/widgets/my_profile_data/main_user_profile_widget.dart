import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/my_profile_data/photo_name_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utl/utls.dart';
import '../events/my_events_widget.dart';
import '../podcasts/my_podcasts_widget.dart';
import 'followers_following_widget.dart';
import 'logout_alert_dialog_widget.dart';

class MainUserProfileWidget extends StatelessWidget {
  const MainUserProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userprofileBloc = BlocProvider.of<UserProfileBloc>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const LogoutAlertDialogWidget();
                      });
                },
              ),
            ],
            centerTitle: true,
            elevation: 0,
            backgroundColor: AppColors.transparentColor,
            iconTheme: Theme.of(context).iconTheme,
            title: Text(
              'Your Profile',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PhotoAndNameWidget(),
                        const SizedBox(
                          height: AppHeight.h10,
                        ),
                        BlocBuilder<LayoutBloc, LayoutState>(
                          builder: (context, layoutState) => Text(
                            layoutState.userDataEntitie!.bio,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: AppHeight.h20,
                        ),
                        const FollowersFollowingWidget(),
                        const SizedBox(
                          height: AppHeight.h10,
                        ),
                        Defaults.defaultButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                AppRoutesNames.updateBasicUserDataInoScreen,
                                arguments:
                                    UpdateUserProfileBasicDataScreenParams(
                                        userprofileBloc));
                          },
                          context: context,
                          text: 'Edit Profile',
                        ),
                        const SizedBox(
                          height: AppHeight.h10,
                        ),
                        SizedBox(
                          height: 50,
                          child: AppBar(
                            bottom: TabBar(
                              indicatorColor: Theme.of(context).primaryColor,
                              indicatorSize: TabBarIndicatorSize.label,
                              tabs: [
                                Tab(
                                  child: Text(
                                    'Podcasts',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Events',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ];
            },
            body: const TabBarView(
              children: [MyPodcastsWidget(), MyEventsWidget()],
            ),
          )),
    );
  }
}
