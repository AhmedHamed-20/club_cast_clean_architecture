import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/my_profile_data/photo_name_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/routes/app_route_names.dart';
import '../events/my_events_widget.dart';
import '../podcasts/my_podcasts_widget.dart';
import 'followers_following_widget.dart';

class MainUserProfileWidget extends StatelessWidget {
  const MainUserProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userprofileBloc = BlocProvider.of<UserProfileBloc>(context);
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
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
                    SizedBox(
                      height: AppHeight.h10,
                    ),
                    BlocBuilder<LayoutBloc, LayoutState>(
                      builder: (context, layoutState) => Text(
                        layoutState.userDataEntitie!.bio,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: AppHeight.h20,
                    ),
                    const FollowersFollowingWidget(),
                    SizedBox(
                      height: AppHeight.h10,
                    ),
                    Defaults.defaultButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AppRoutesNames.updateBasicUserDataInoScreen,
                          arguments: UpdateUserProfileBasicDataScreenParams(
                            userprofileBloc,
                          ),
                        );
                      },
                      context: context,
                      text: AppStrings.editProfile.tr(),
                    ),
                    SizedBox(
                      height: AppHeight.h10,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: AppBar(
                        bottom: TabBar(
                          indicatorColor: Theme.of(context).primaryColor,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: [
                            Tab(
                              child: Text(
                                AppStrings.podcasts.tr(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Tab(
                              child: Text(
                                AppStrings.events.tr(),
                                style: Theme.of(context).textTheme.titleMedium,
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
      ),
    );
  }
}
