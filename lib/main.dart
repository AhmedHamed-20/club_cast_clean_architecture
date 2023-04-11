import 'package:club_cast_clean_architecture/core/cache/cache_setup.dart';
import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/core/services/service_locator.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import 'package:club_cast_clean_architecture/features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
  await EasyLocalization.ensureInitialized();
  final String accessToken = await servicelocator<CacheService>()
          .getData(key: AppStrings.accessTokenKey) ??
      '';
  ConstVar.accessToken = accessToken;
  runApp(EasyLocalization(
    supportedLocales: const [ConstVar.enLocale, ConstVar.arLocale],
    path: AssetsPath
        .languagesPath, // <-- change the path of the translation files
    fallbackLocale: ConstVar.enLocale,
    child: MyApp(
      appRoutes: AppRoutes(),
      accessToken: accessToken,
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.appRoutes, required this.accessToken});
  final AppRoutes appRoutes;
  final String accessToken;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void didChangeDependencies() {
    final appLanguage = servicelocator<CacheService>()
            .getData(key: AppStrings.appLanguageKey) ??
        'en';
    if (appLanguage == 'en') {
      context.setLocale(ConstVar.enLocale);
    } else {
      context.setLocale(ConstVar.arLocale);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => servicelocator<AuthBloc>()),
        BlocProvider(
            create: (context) => servicelocator<LayoutBloc>()
              ..add(GetChachedThemeValueEvent(key: ConstVar.appThemeKey))
              ..add(GetCachedAppColorsValueEvent(key: ConstVar.appColorKey))
              ..add(const GetCachedAppLanguageEvent(
                  key: AppStrings.appLanguageKey))),
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
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'Club Cast',
            theme: state.baseThemeClass.lightMode(),
            darkTheme: state.baseThemeClass.darkMode(),
            themeMode: state.themeModeValue.index == 0
                ? ThemeMode.light
                : ThemeMode.dark,
            onGenerateRoute: widget.appRoutes.generateRoutes,
            routes: {
              AppRoutesNames.splashScreen: (context) =>
                  SplashScreen(accessToken: widget.accessToken),
            },
            initialRoute: AppRoutesNames.splashScreen,
          ),
        ),
      ),
    );
  }
}
