import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      fontSize: 22.0,
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.black,
    indicatorSize: TabBarIndicatorSize.label,
    unselectedLabelColor: Colors.grey,
  ),
  scaffoldBackgroundColor: Colors.white,
);
