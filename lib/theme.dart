import 'package:flutter/material.dart';

const choreBuddiesPrimary = const Color(0xFF01233F);

ThemeData buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: choreBuddiesPrimary,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: choreBuddiesPrimary,
      shape: RoundedRectangleBorder(),
      textTheme: ButtonTextTheme.primary,
    ),
    scaffoldBackgroundColor: Colors.white,
  );
}
