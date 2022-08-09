import 'package:flutter/material.dart';

//---text styles---
const TextStyle regularText = TextStyle(
  fontSize: 16,
  color: Colors.black,
);

final TextStyle regularWhiteText = regularText.copyWith(
  color: Colors.white,
);

final TextStyle smallWhiteText = regularText.copyWith(
  color: Colors.white,
  fontSize: 14
);

final TextStyle largeWhiteText = regularText.copyWith(
  color: Colors.red,
  fontSize: 18
);

final textTheme = ThemeData.dark().textTheme;
final bodyStyle1 = textTheme.bodyText1?.copyWith(decorationColor: Colors.transparent);

//---Overall app theme setup---
final currentTheme =   ThemeData.dark().copyWith(
  primaryColor: Colors.grey[800],
  toggleableActiveColor: Colors.cyan[300],
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.cyan[300],
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: ThemeData.dark().dialogBackgroundColor,
    contentTextStyle: bodyStyle1,
    actionTextColor: Colors.cyan[300],
  ),
  textTheme: textTheme.copyWith(
    bodyText1: bodyStyle1,
  ),
);
