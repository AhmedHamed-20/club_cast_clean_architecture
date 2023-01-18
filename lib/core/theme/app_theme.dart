import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData darkMode = ThemeData(
    colorScheme: ColorScheme.dark(
        secondary: AppColors.primaryColorDark,
        primary: AppColors.primaryColorDark),
    splashColor: AppColors.primaryColorDark,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      modalBackgroundColor: Colors.transparent,
    ),
    appBarTheme: AppBarTheme(
      titleSpacing: 20,
      systemOverlayStyle: const SystemUiOverlayStyle(),
      backgroundColor: AppColors.transparentColor,
      elevation: 0.0,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: AppFontSize.s20,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: AppColors.backgroundColorDark,
    textTheme: TextTheme(
      titleMedium: GoogleFonts.rubik(
        color: AppColors.titleTextColorDark,
        fontSize: AppFontSize.s18,
      ),
      titleLarge: GoogleFonts.rubik(
        color: AppColors.titleTextColorDark,
        fontSize: AppFontSize.s18,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.rubik(
        color: AppColors.titleTextColorDark,
        fontSize: AppFontSize.s16,
      ),
    ),
    iconTheme: IconThemeData(
      color: AppColors.iconColorWhite,
      size: 28,
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColorDark,
    primaryColor: AppColors.primaryColorDark,
  );

  static ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
        secondary: AppColors.primaryColorLight,
        primary: AppColors.primaryColorLight),
    splashColor: AppColors.primaryColorLight,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      modalBackgroundColor: Colors.transparent,
    ),

    backgroundColor: Colors.white,
    textTheme: TextTheme(
      titleMedium: GoogleFonts.rubik(
        fontSize: AppFontSize.s18,
        color: AppColors.titleTextColor,
      ),
      titleLarge: GoogleFonts.rubik(
        color: AppColors.titleTextColor,
        fontSize: AppFontSize.s18,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.rubik(
        color: AppColors.titleTextColor,
        fontSize: AppFontSize.s16,
      ),
    ),
    appBarTheme: AppBarTheme(
      titleSpacing: 20,
      systemOverlayStyle: const SystemUiOverlayStyle(),
      backgroundColor: AppColors.backgroundColorWhite,
      elevation: 0.0,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: AppFontSize.s20,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(
      color: AppColors.iconColorGrey,
      size: 28,
    ),
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    primaryColor: AppColors.primaryColorLight,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xff5ADAAC),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      elevation: 20,
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(
        size: 28,
      ),
      unselectedIconTheme: IconThemeData(
        size: 25,
      ),
    ),
    //  backgroundColor: Color(0xffF6F9F4),
  );
}
