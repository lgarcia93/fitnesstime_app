import 'package:flutter/material.dart';

final Color primaryColor = const Color(0xFF2A0646);
final Color lightColor = const Color(0xFFF2F2F2);
final Color scaffoldBackgroundColor = const Color(0xFFF2F2F2);

final TextStyle buttonTextStyle = TextStyle(fontSize: 14.0);

final ThemeData defaultTheme = ThemeData(
  primaryColor: primaryColor,
  colorScheme: ColorScheme.light(
    primary: primaryColor,
    onPrimary: Colors.white,
  ),
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: primaryColor,
    ),
    color: scaffoldBackgroundColor,
    brightness: Brightness.light,
    elevation: 0.0,
  ),
  iconTheme: IconThemeData(
    color: primaryColor,
    size: 16,
  ),
  chipTheme: ChipThemeData.fromDefaults(
    primaryColor: primaryColor,
    secondaryColor: Colors.grey,
    labelStyle: TextStyle(
      fontSize: 14.0,
      color: primaryColor,
    ),
  ).copyWith(
    selectedColor: primaryColor,
    secondaryLabelStyle: TextStyle(
      color: Colors.white,
    ),
    labelPadding: EdgeInsets.all(4.0),
    padding: EdgeInsets.all(4.0),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(7.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: primaryColor,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(7.0),
    ),
    contentPadding: EdgeInsets.only(
      left: 16.0,
      right: 16.0,
      bottom: 8.0,
      top: 8.0,
    ),
  ),
  textTheme: TextTheme(
    headline6: TextStyle(
      fontSize: 24.0,
    ),
    bodyText2: TextStyle(
      fontSize: 24.0,
    ),
    bodyText1: TextStyle(
      fontSize: 18.0,
    ),
  ),
);
