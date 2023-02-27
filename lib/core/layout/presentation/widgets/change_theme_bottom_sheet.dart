import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:flutter/material.dart';

import 'change_app_colors_widget.dart';
import 'change_app_theme_value.dart';

class ThemeChangeBottomSheetWidget extends StatelessWidget {
  const ThemeChangeBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQueryOfMethods.getAppHeight(context) * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Customize App Theme',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
              height: AppHeight.h12,
            ),
            Text(
              'App Theme',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const ChangeAppThemeValueWidget(),
            Text(
              'App Colors',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const ChangeAppColorsWidget(),
          ],
        ),
      ),
    );
  }
}
