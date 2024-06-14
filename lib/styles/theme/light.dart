import 'package:custom_soft/styles/colors.dart';
import 'package:custom_soft/styles/texts.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData (
  //inputDecorationTheme: decorationTheme,
  textTheme: textTheme,
  colorScheme: const ColorScheme(
    primary: UIColors.primaryColor ,
    primaryContainer: UIColors.primaryColor, 
    secondary: UIColors.secondaryColor, 
    secondaryContainer: UIColors.secondaryColor, 
    tertiary: UIColors.tertiaryColor,
    background: UIColors.white, 
    brightness: Brightness.light,
    onBackground: UIColors.white,
    onPrimary: UIColors.primaryColor,
    onSecondary: UIColors.secondaryColor,
    onTertiary: UIColors.tertiaryColor,
    error: UIColors.error, 
    onError: UIColors.error,
    surface: UIColors.surface,
    onSurface: UIColors.surface  
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: UIColors.white,
    iconTheme: IconThemeData(
      color: UIColors.primaryColor
    ),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: UIColors.black
    )
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData (
    backgroundColor: UIColors.black,
    selectedItemColor: UIColors.primaryColor,
    unselectedItemColor: UIColors.white,
    elevation: 1,
  ),
  dialogTheme: const DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
    errorStyle: textTheme.bodyMedium!.copyWith(
      color: UIColors.error,
      fontWeight: FontWeight.w500
    ),
    filled: true,
    fillColor: UIColors.greyBottomBar,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData (
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor: MaterialStateProperty.all(UIColors.tertiaryColor),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        )
      ),
      shadowColor: MaterialStateProperty.all(
        Colors.transparent
      ),
      textStyle: MaterialStateProperty.all(
        const TextStyle (
          fontWeight: FontWeight.normal,
          fontSize: 20,
          color: UIColors.white
        ),
      )
    ),
  ),
  textButtonTheme: TextButtonThemeData (
    style: ButtonStyle(      
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      padding: MaterialStateProperty.all(EdgeInsets.zero)
    ),
  ),
  cardTheme: const CardTheme(
    color: UIColors.white
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: UIColors.black,
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    shape: StarBorder()
  ),
  scaffoldBackgroundColor: UIColors.white,
  brightness: Brightness.light,
  primaryColor: UIColors.primaryColor,
);