import 'package:flutter/material.dart';

class Styles {
  // ----------------- COLOURS
  static final Color yellow = Color(0xfffae100);
  static final Color midnightBlue = Color(0xff00205b);
  static final Color transMidnightBlue = Color(0x7000205b);
  static final Color grey = Color(0xff576a80);
  static final Color red = Color(0xffe05c41);
  static final Color transparent = Color(0x00000000);
  static final Color softGrey = Color(0xfff2f5f8);
  static final Color mediumGrey = Color(0xff828282);

  // ----------------- SIZES
  // ---------- APP
  static final double appBarHorizontalPadding = 10;
  static final double normalRadius = 20;
  static final double imageMargin = 8;
  static final double spacing = 20;
  static final double heightFromAppBar = 80;
  // ---------- TEXT
  static final double textPadding = 10;
  // ---------- ICON
  static double iconSize = 24;
  static final double iconPadding = 10;
  static final double iconPaddingPadding = 10;

  // ----------------- NOTE: GENERAL TEXT
  static TextStyle pStyle = TextStyle(
    fontFamily: "Poppins",
    fontSize: 18,
    color: midnightBlue,
  );

  // ------ e.g. "DGHA"
  static TextStyle h1Style = pStyle.copyWith(fontSize: 32, fontWeight: FontWeight.w900);

  // ------ e.g. "General Info"
  static TextStyle h2Style = pStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w700);

  // ------ e.g. "Federal"
  static TextStyle h3Style = pStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w600);

  // ------ e.g. "Customer Service"
  static TextStyle h4Style = pStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600);

  // ------ Drawer Tiles Font
  static TextStyle txtBtnStyle = h3Style.copyWith(fontWeight: FontWeight.w500);

  // ------ e.g. "Japanese"
  static TextStyle highlightText = pStyle.copyWith(backgroundColor: yellow);

  // ------ link
  static TextStyle linkStyle = highlightText.copyWith(
    decoration: TextDecoration.underline,
    decorationColor: midnightBlue,
    fontWeight: FontWeight.w500,
  );

  // ------ e.g. "Skip"
  static TextStyle yellowTxtBtnStyle = pStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: yellow,
  );

  // ------ e.g. "Sign In"
  static TextStyle btnTextBlueUnderlineStyle = yellowTxtBtnStyle.copyWith(
    decoration: TextDecoration.underline,
    decorationThickness: 3,
    decorationColor: Styles.midnightBlue,
    color: midnightBlue,
  );
}
