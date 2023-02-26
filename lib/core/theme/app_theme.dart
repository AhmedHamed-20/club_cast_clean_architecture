import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static DatePickerTheme datePickerTheme(BuildContext context) =>
      DatePickerTheme(
        backgroundColor: Theme.of(context).colorScheme.background,
        cancelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).primaryColor,
            ),
        doneStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).primaryColor,
            ),
        itemStyle: Theme.of(context).textTheme.titleMedium!,
      );
}

class Material3Colors {
  // This theme was made for FlexColorScheme version 6.1.1. Make sure
// you use same or higher version, but still same major version. If
// you use a lower version, some properties may not be supported. In
// that case you can also remove them after copying the theme to your app.
  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.materialBaseline,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
    ),
    textTheme: TextTheme(
      titleMedium: GoogleFonts.roboto(
        fontSize: AppFontSize.s18,
        color: AppColors.titleTextColor,
      ),
      titleLarge: GoogleFonts.roboto(
        color: AppColors.titleTextColor,
        fontSize: AppFontSize.s18,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.roboto(
        color: AppColors.titleTextColor,
        fontSize: AppFontSize.s16,
      ),
    ),
    useMaterial3ErrorColors: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    // To use the playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );
  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.materialBaseline,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
    ),
    textTheme: TextTheme(
      titleMedium: GoogleFonts.roboto(
        color: AppColors.titleTextColorDark,
        fontSize: AppFontSize.s18,
      ),
      titleLarge: GoogleFonts.roboto(
        color: AppColors.titleTextColorDark,
        fontSize: AppFontSize.s18,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.roboto(
        color: AppColors.titleTextColorDark,
        fontSize: AppFontSize.s16,
      ),
    ),
    useMaterial3ErrorColors: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    // To use the Playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,
}
