import 'dart:async';

import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routes/app_route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.accessToken}) : super(key: key);
  final String accessToken;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () async {
      String startApp;

      if (widget.accessToken == '') {
        startApp = AppRoutesNames.loginScreen;
      } else {
        startApp = AppRoutesNames.layoutScreen;
      }
      Navigator.of(context).pushNamedAndRemoveUntil(startApp, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Container(
          width: 200.w,
          height: 200.h,
          padding: const EdgeInsets.all(AppPadding.p30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r100),
            color: Theme.of(context).colorScheme.background,
          ),
          child: Center(
            child: Image.asset(
              AssetsPath.imageLogo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
