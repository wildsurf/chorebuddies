import 'package:flutter/material.dart';

const choreBuddiesPrimary = const Color(0xFF01233F);
const choreBuddiesSecondary = const Color(0xFFD0372F);

ThemeData buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: choreBuddiesPrimary,
    secondaryHeaderColor: choreBuddiesSecondary,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: choreBuddiesPrimary,
      shape: RoundedRectangleBorder(),
      textTheme: ButtonTextTheme.primary,
    ),
    scaffoldBackgroundColor: Colors.white,

  );
}
