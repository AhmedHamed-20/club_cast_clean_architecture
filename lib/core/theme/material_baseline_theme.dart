import 'package:club_cast_clean_architecture/core/theme/base_theme_class.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';

class MaterialBaseline extends BaseThemeClass {
  const MaterialBaseline();
  @override
  ThemeData lightMode() {
    return FlexThemeData.light(
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
    );
  }

  @override
  ThemeData darkMode() {
    return FlexThemeData.dark(
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
    );
  }
}
