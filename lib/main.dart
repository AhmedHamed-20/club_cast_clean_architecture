import 'package:club_cast_clean_architecture/core/cache/cache_setup.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/core/services/service_locator.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import 'core/SplashScreen/splash_screen.dart';
import 'core/routes/app_route_names.dart';
import 'core/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.init();
  await ServiceLocator.initDio();
  await ServiceLocator.initSharedPref();
  final String accessToken =
      await servicelocator<CacheHelper>().getData(key: 'accessToken') ?? '';
  ConstVar.accessToken = accessToken;
  runApp(MyApp(
    appRoutes: AppRoutes(),
    accessToken: accessToken,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRoutes, required this.accessToken});
  final AppRoutes appRoutes;
  final String accessToken;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => servicelocator<AuthBloc>()),
        BlocProvider(
            create: (context) => servicelocator<LayoutBloc>()
              ..add(GetChachedThemeValueEvent(key: ConstVar.appThemeKey))
              ..add(GetCachedAppColorsValueEvent(key: ConstVar.appColorKey))),
        BlocProvider(
            create: (context) =>
                servicelocator<CommonPlayingPodcastBlocBloc>()),
        BlocProvider(create: (context) => servicelocator<SocketsVoiceBloc>()),
        BlocProvider(create: (context) => servicelocator<ChatBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => BlocBuilder<LayoutBloc, LayoutState>(
          builder: (context, state) => MaterialApp(
            title: 'Club Cast',
            theme: state.baseThemeClass.lightMode(),
            darkTheme: state.baseThemeClass.darkMode(),
            themeMode: state.themeModeValue.index == 0
                ? ThemeMode.light
                : ThemeMode.dark,
            onGenerateRoute: appRoutes.generateRoutes,
            routes: {
              AppRoutesNames.splashScreen: (context) =>
                  SplashScreen(accessToken: accessToken),
            },
            initialRoute: AppRoutesNames.splashScreen,
          ),
        ),
      ),
    );
  }
}
