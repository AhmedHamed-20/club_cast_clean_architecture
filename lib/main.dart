import 'package:club_cast_clean_architecture/core/cache/chache_setup.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/services/service_locator.dart';
import 'package:club_cast_clean_architecture/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'core/network/dio.dart';
import 'core/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.init();
  await DioHelper.init();
  await CacheHelper.init();
  runApp(MyApp(
    appRoutes: AppRoutes(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRoutes});
  final AppRoutes appRoutes;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Club Cast',
      theme: AppTheme.lightMode,
      darkTheme: AppTheme.darkMode,
      themeMode: ThemeMode.light,
      onGenerateRoute: appRoutes.generateRoutes,
      initialRoute: AppRoutesNames.loginScreen,
    );
  }
}
