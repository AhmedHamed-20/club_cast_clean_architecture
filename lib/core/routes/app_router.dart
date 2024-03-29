import 'package:club_cast_clean_architecture/core/SplashScreen/splash_screen.dart';
import 'package:club_cast_clean_architecture/core/common_playing_podcast_feature/presentation/screens/likes_users_screens.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/screens/layout_screen.dart';
import 'package:club_cast_clean_architecture/core/widgets/podcast_information_screen.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/screens/forget_password_screen.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/screens/login_screen.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/screens/other_user_followers_following_screen.dart';
import 'package:club_cast_clean_architecture/features/OtherUsersProfiles/presentation/screens/other_user_profile_screen.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/screens/all_my_following_events_screen.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/screens/create_event_screen.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/screens/edit_profile_basic_info_screen.dart';
import 'package:club_cast_clean_architecture/features/UserProfile/presentation/screens/followers_following_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/Auth/presentation/screens/signup_screen.dart';
import '../../features/Rooms/presentation/screens/private_chat_room_screen.dart';
import '../../features/Rooms/presentation/screens/room_screen.dart';
import '../../features/Search/presentation/screens/all_podcasts_screen.dart';
import '../../features/UserProfile/presentation/screens/edit_event_screen.dart';
import '../../features/UserProfile/presentation/screens/upload_podcast_screen.dart';
import '../../features/UserProfile/presentation/screens/user_profile_screen.dart';
import '../constants/base_podcast_entitie/base_podcast_entitie.dart';
import '../constants/params.dart';
import 'app_route_names.dart';

class AppRoutes {
  Route? generateRoutes(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case AppRoutesNames.loginScreen:
        return MaterialPageRoute(builder: (context) {
          return const LoginScreen();
        });
      case AppRoutesNames.splashScreen:
        String argument = args as String;
        return MaterialPageRoute(builder: (context) {
          return SplashScreen(
            accessToken: argument,
          );
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
        //    UserDataEntitie arguments = args as UserDataEntitie;
        return MaterialPageRoute(
          builder: (context) => const UserProfileScreen(),
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
                  child: const EditUserProfileBasicDataScreen(),
                ));

      case AppRoutesNames.editEventScreen:
        EditEventScreenParams arguments = args as EditEventScreenParams;
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: arguments.myEventsBloc,
                  child: EditEventScreen(
                    myEventEntitie: arguments.myEventEntitie,
                  ),
                ));
      case AppRoutesNames.createEventScreen:
        CreateEventScreenParams arguments = args as CreateEventScreenParams;
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: arguments.myEventsBloc,
                  child: const CreateEventScreen(),
                ));

      case AppRoutesNames.uploadPodcastScreen:
        UploadPodcastScreenParams arguments = args as UploadPodcastScreenParams;

        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: arguments.myPodcastBloc,
                  child: const UploadPodcastScreen(),
                ));
      case AppRoutesNames.otherUserProfileScreen:
        OtherUserProfileScreenParams arguments =
            args as OtherUserProfileScreenParams;
        return MaterialPageRoute(
            builder: (context) => OtherUserProfileScreen(
                  otherUserProfileScreenParams: arguments,
                ));

      case AppRoutesNames.otherUserFollowersFollowingScreen:
        OtherUserFollowersFollowingScreenParams arguments =
            args as OtherUserFollowersFollowingScreenParams;
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: arguments.otherUserProfileBloc,
                  child: OtherUserFollowersFollowingScreen(
                      isFollowers: arguments.isFollwers,
                      userId: arguments.userId),
                ));

      case AppRoutesNames.roomScreen:
        return MaterialPageRoute(builder: (context) {
          return const RoomScreen();
        });
      case AppRoutesNames.privateChatRoomScreen:
        PrivateChatRoomScreenParams arguments =
            args as PrivateChatRoomScreenParams;
        return MaterialPageRoute(builder: (context) {
          return PrivateChatRoomScreen(
            params: arguments,
          );
        });
      case AppRoutesNames.allPodcastsScreen:
        AllPodcastsScreenParams arguments = args as AllPodcastsScreenParams;
        return MaterialPageRoute(builder: (context) {
          return BlocProvider.value(
              value: arguments.searchBloc, child: const AllPodcastsScreen());
        });
      case AppRoutesNames.allMyFollowingEventsScreen:
        return MaterialPageRoute(builder: (context) {
          return const AllMyFollowingEventsScreen();
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
