import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData lightTheme=ThemeData(
  scaffoldBackgroundColor: HexColor('F9F9F8'),
  appBarTheme:  AppBarTheme(
    iconTheme: const IconThemeData(
      color: Colors.grey,
    ),
    titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('F9F9F8'),
        statusBarIconBrightness: Brightness.dark
    ),
    backgroundColor: HexColor('F9F9F8'),
    elevation: 0.0,
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      selectedItemColor: lightGreen,),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.black
    ),
    bodyText2: TextStyle(
      fontSize: 15,
    ),
  ),
  fontFamily: 'Janna',
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: lightGreen,
      elevation: 10,
  ),
  iconTheme: IconThemeData(
    color: Colors.grey.shade400
  ),
  primarySwatch: green,
);


ThemeData darkTheme=ThemeData(
  primarySwatch: Colors.deepOrange,
  primaryColor: HexColor('22272E'),
  scaffoldBackgroundColor: HexColor('22272E'),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('22272E'),
        statusBarIconBrightness: Brightness.light),
    backgroundColor: HexColor('22272E'),
    elevation: 0.0,
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('22272E'),
    elevation: 10.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white
    ),
    bodyText2: TextStyle(
        fontSize: 15,
        color: Colors.white
    ),
  ),
);