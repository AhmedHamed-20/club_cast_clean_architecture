import 'package:club_cast_clean_architecture/constants/constants.dart';
import 'package:flutter/material.dart';

import 'core/routes/app_router.dart';

void main() {
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
      theme: ThemeData(),
      onGenerateRoute: appRoutes.generateRoutes,
      initialRoute: AppRoutesNames.loginScreen,
    );
  }
}
