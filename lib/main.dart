import 'package:club_cast_clean_architecture/core/cache/chache_setup.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:club_cast_clean_architecture/core/services/service_locator.dart';
import 'package:club_cast_clean_architecture/core/theme/app_theme.dart';
import 'package:club_cast_clean_architecture/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_playing_podcast_feature/presentation/bloc/common_playing_podcast_bloc_bloc.dart';
import 'core/network/dio.dart';
import 'core/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.init();
  await DioHelper.init();
  await CacheHelper.init();
  final String accessToken =
      await CacheHelper.getData(key: 'accessToken') ?? '';
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
        BlocProvider(create: (context) => servicelocator<LayoutBloc>()),
        BlocProvider(
            create: (context) =>
                servicelocator<CommonPlayingPodcastBlocBloc>()),
      ],
      child: MaterialApp(
        title: 'Club Cast',
        theme: Material3Colors.light,
        darkTheme: Material3Colors.dark,
        themeMode: ThemeMode.dark,
        onGenerateRoute: appRoutes.generateRoutes,
        initialRoute: accessToken == ''
            ? AppRoutesNames.loginScreen
            : AppRoutesNames.layoutScreen,
      ),
    );
  }
}
