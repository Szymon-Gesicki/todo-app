import 'package:flutter/material.dart';
import 'package:todo/ui/style/colors.dart';

final appTheme = ThemeData(
    fontFamily: "AvenirNext",
    textTheme: TextTheme(
      headline1: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 32,
      ),
      headline2: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      headline3: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      headline4: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 14,
        letterSpacing: 2,
      ),
      headline5: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      headline6: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 10,
      ),
    ).apply(displayColor: Colors.black),
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.blueGrey,
    primaryColor: AppColors.primaryColor,
    primaryColorDark: AppColors.primaryColor,
    primaryColorLight: AppColors.primaryColor.withOpacity(0.4),
    toggleableActiveColor: AppColors.primaryColor,
    backgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      primaryVariant: AppColors.darkBlue,
      secondary: AppColors.primaryColor,
      secondaryVariant: AppColors.darkBlue,
    ));
