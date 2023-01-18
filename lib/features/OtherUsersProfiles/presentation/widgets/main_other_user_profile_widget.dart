import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';

import 'bio_widget.dart';
import 'follow_un_follow_button_widget.dart';
import 'other_user_followers_following_widget.dart';
import 'other_user_profile_name_widget.dart';

class MainOtherUserProfileWidget extends StatelessWidget {
  const MainOtherUserProfileWidget({
    Key? key,
  }) : super(key: key);

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
          body: TabBarView(
            children: [Container(), Container()],
          )),
    );
  }
}
