import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/core/services/service_locator.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/MyEventsBloc/my_events_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/MyPodcastBloc/my_podcast_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/bloc/userprofile_bloc.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/widgets/my_profile_data/main_user_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutBloc, LayoutState>(
      builder: (context, layoutState) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => servicelocator<UserProfileBloc>()),
          BlocProvider(
              create: (context) => servicelocator<MyPodcastBloc>()
                ..add(
                  MyPodcastsGetEvent(
                    accessToken: ConstVar.accessToken,
                    page: 1,
                  ),
                )),
          BlocProvider(
            create: (context) => servicelocator<MyEventsBloc>()
              ..add(
                MyEventsGetEvent(accessToken: ConstVar.accessToken, page: 1),
              ),
          )
        ],
        child: const MainUserProfileWidget(),
      ),
    );
  }
}
