import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'typography.dart';

// ignore: non_constant_identifier_names
ThemeData dark_theme() => ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => AppColors.primary),
        ),
      ),
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.greyDarker),
      primaryColor: AppColors.primary,
      primaryColorLight: AppColors.primaryAccent,
      appBarTheme: const AppBarTheme(
        color: AppColors.primary,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemStatusBarContrastEnforced: true,
          statusBarColor: AppColors.white,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
      ),
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: const TextTheme().apply(
        bodyColor: AppColors.greyLight,
        displayColor: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.greyDarker,
      primaryTextTheme: textTheme,
      iconTheme: const IconThemeData(color: AppColors.greyLight),
      colorScheme:
          const ColorScheme.dark().copyWith(background: AppColors.black),
    );
