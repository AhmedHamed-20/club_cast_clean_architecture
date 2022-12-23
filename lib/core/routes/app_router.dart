import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/screens/layout_screen.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/screens/forget_password_screen.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/screens/login_screen.dart';
import 'package:club_cast_clean_architecture/features/MyFollowingPodcasts/presentation/screens/likes_users_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/Auth/presentation/screens/signup_screen.dart';
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
          return BlocProvider.value(
              value: arguments.podcastBloc,
              child: LikesUsersScreen(podcastId: arguments.podcastId));
        });
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
