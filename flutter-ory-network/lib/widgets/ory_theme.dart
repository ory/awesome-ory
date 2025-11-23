// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OryTheme {
  OryTheme._();

  static const Color primaryColor = Color(0xFF1E293B);
  static const Color linkColor = Color(0xFF4F46E5);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color formDefaultColor = Color(0xFF64748B);
  static const Color formBorderColor = Color(0xFFE2E8F0);
  static const Color formBorderFocusColor = Color(0xFF0F172A);

  static MaterialColor primaryColorSwatch = MaterialColor(
    primaryColor.value,
    const <int, Color>{
      50: Color(0xFF1E293B),
      100: Color(0xFF1E293B),
      200: Color(0xFF1E293B),
      300: Color(0xFF1E293B),
      400: Color(0xFF1E293B),
      500: Color(0xFF1E293B),
      600: Color(0xFF1E293B),
      700: Color(0xFF1E293B),
      800: Color(0xFF1E293B),
      900: Color(0xFF1E293B),
    },
  );

  static const InputDecorationTheme textFieldTheme = InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.25,
          color: formDefaultColor),
      errorStyle: TextStyle(color: errorColor),
      suffixIconColor: formDefaultColor,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: formBorderFocusColor)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: formBorderColor),
      ),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: errorColor)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: errorColor)));

// buttons
  static final TextButtonThemeData textButtonThemeData = TextButtonThemeData(
      style: ButtonStyle(
    visualDensity: VisualDensity.compact,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    padding: MaterialStateProperty.all(
      EdgeInsets.zero,
    ),
    foregroundColor: MaterialStateProperty.all<Color>(linkColor),
    textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, height: 1.5)),
  ));

  static final FilledButtonThemeData filledButtonThemeData =
      FilledButtonThemeData(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)))));

  static final OutlinedButtonThemeData outlinedButtonThemeData =
      OutlinedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)))));

  static final ThemeData defaultTheme = ThemeData(
    primarySwatch: primaryColorSwatch,
    fontFamily: GoogleFonts.getFont('Inter').fontFamily,
    textButtonTheme: textButtonThemeData,
    appBarTheme:
        const AppBarTheme(iconTheme: IconThemeData(color: primaryColor)),
    filledButtonTheme: filledButtonThemeData,
    outlinedButtonTheme: outlinedButtonThemeData,
    inputDecorationTheme: textFieldTheme,
  );
}
