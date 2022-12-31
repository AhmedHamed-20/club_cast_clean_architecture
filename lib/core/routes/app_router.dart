import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/presentation/screens/likes_users_screens.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/layout/domain/entities/user_data_entitie.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/screens/layout_screen.dart';
import 'package:club_cast_clean_architecture/core/widgets/podcast_information_screen.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/screens/forget_password_screen.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/screens/login_screen.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/screens/edit_profile_basic_info_screen.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/screens/followers_following_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/Auth/presentation/screens/signup_screen.dart';
import '../../features/UserProfile/presentation/screens/edit_event_screen.dart';
import '../../features/UserProfile/presentation/screens/user_profile_screen.dart';
import '../constants/base_podcast_entitie/base_podcast_entitie.dart';
import '../constants/params.dart';

class AppRoutes {
  Route? generateRoutes(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case AppRoutesNames.loginScreen:
        return MaterialPageRoute(builder: (context) {
          return const LoginScreen();
        });
      case AppRoutesNames.layoutScreen:
        return MaterialPageRoute(builder: (context) {
          return const LayoutScreen();
        });
      case AppRoutesNames.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen(),
        );

      case AppRoutesNames.signUpScreen:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());

      case AppRoutesNames.podcastUsersLikesScreen:
        LikesUsersScreenParams arguments = args as LikesUsersScreenParams;
        return MaterialPageRoute(builder: (context) {
          return LikesUsersScreen(podcastId: arguments.podcastId);
        });
      case AppRoutesNames.podcastInfoScreen:
        BasePodcastEntitie arguments = args as BasePodcastEntitie;
        return MaterialPageRoute(builder: (context) {
          return PodcastInformationScreen(
            podcastInformationEntitie: arguments,
          );
        });

      case AppRoutesNames.userProfileScreen:
        UserDataEntitie arguments = args as UserDataEntitie;
        return MaterialPageRoute(
          builder: (context) => UserProfileScreen(userDataEntitie: arguments),
        );

      case AppRoutesNames.myProfileFollowersFollowingScreen:
        MyProfileFollowersFollowingScreenParams argument =
            args as MyProfileFollowersFollowingScreenParams;
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: argument.userprofileBloc,
                  child: FollowersFollowingScreen(
                      myProfileFollowersFollowingScreenParams: argument),
                ));
      case AppRoutesNames.updateBasicUserDataInoScreen:
        UpdateUserProfileBasicDataScreenParams arguments =
            args as UpdateUserProfileBasicDataScreenParams;
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: arguments.userprofileBloc,
                  child: EditUserProfileBasicDataScreen(
                      userDataEntitie: arguments.userDataEntitie),
                ));

      case AppRoutesNames.editEventScreen:
        EditEventScreenParams arguments = args as EditEventScreenParams;
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: arguments.userprofileBloc,
                  child: EditEventScreen(
                    myEventEntitie: arguments.myEventEntitie,
                  ),
                ));
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('No Routes Availble'),
            ),
          );
        });
    }
  }
}
