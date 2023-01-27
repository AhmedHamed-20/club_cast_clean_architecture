import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/bloc/otherusersprofiles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bio_widget.dart';
import 'follow_un_follow_button_widget.dart';
import 'other_user_events.dart';
import 'other_user_followers_following_widget.dart';
import 'other_user_podcasts_widget.dart';
import 'other_user_profile_name_widget.dart';

class MainOtherUserProfileWidget extends StatelessWidget {
  const MainOtherUserProfileWidget({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final String userId;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const OtherUserProfilePhotoNameWidget(),
                      const SizedBox(
                        height: AppHeight.h10,
                      ),
                      const BioWidget(),
                      const SizedBox(
                        height: AppHeight.h10,
                      ),
                      const OtherUserFollowersFollowingWidget(),
                      const SizedBox(
                        height: AppHeight.h10,
                      ),
                      const FollowUnFollowButton(),
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
              ),
            ];
          },
          body: BlocBuilder<OtherUserProfileBloc, OtherUserProfileState>(
            builder: (context, state) => TabBarView(
              children: [
                OtherUserPodcastsWidget(userId: userId),
                state.isFollowed
                    ? const OtherUserEventsWidget()
                    : Center(
                        child: Text(
                          'You need to follow this user to see their events',
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
              ],
            ),
          )),
    );
  }
}
