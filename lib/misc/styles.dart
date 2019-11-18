import 'package:flutter/material.dart';

class Styles {
  // ----------------- COLOURS
  static const Color yellow = Color(0xfffae100);
  static const Color midnightBlue = Color(0xff00205b);
  static const Color transMidnightBlue = Color(0x7000205b);
  static const Color grey = Color(0xff576a80);
  static const Color red = Color(0xffe05c41);
  static const Color transparent = Color(0x00000000);
  static const Color softGrey = Color(0xfff2f5f8);
  static const Color mediumGrey = Color(0xff828282);

  // ----------------- SIZES
  // ---------- APP
  static const double appBarHorizontalPadding = 10;
  static const double normalRadius = 20;
  static const double imageMargin = 8;
  static const double spacing = 20;
  static const double heightFromAppBar = 80;
  // ---------- TEXT
  static const double textPadding = 10;
  // ---------- ICON
  static const double iconSize = 24;
  static const double iconPadding = 10;
  static const double iconPaddingPadding = 10;

  // ----------------- NOTE: GENERAL TEXT
  static const TextStyle pStyle = TextStyle(
    fontFamily: "Poppins",
    fontSize: 18,
    color: midnightBlue,
  );

  // ------ e.g. "DGHA"
  static final TextStyle h1Style = pStyle.copyWith(fontSize: 32, fontWeight: FontWeight.w900);

  // ------ e.g. "General Info"
  static final TextStyle h2Style = pStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w700);

  // ------ e.g. "Federal"
  static final TextStyle h3Style = pStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w600);

  // ------ e.g. "Customer Service"
  static final TextStyle h4Style = pStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600);

  // ------ Drawer Tiles Font
  static final TextStyle txtBtnStyle = h3Style.copyWith(fontWeight: FontWeight.w500);

  // ------ e.g. "Japanese"
  static final TextStyle highlightText = pStyle.copyWith(backgroundColor: yellow);

  // ------ e.g. "No Review"
  static final TextStyle boldPStyle = pStyle.copyWith(fontWeight: FontWeight.w600);

  // ------
  // ------ link
  static final TextStyle linkStyle = highlightText.copyWith(
    decoration: TextDecoration.underline,
    decorationColor: midnightBlue,
    fontWeight: FontWeight.w500,
  );

  // ------ e.g. "Skip"
  static final TextStyle yellowTxtBtnStyle = pStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: yellow,
  );

  static TextStyle blackTxtBtnStyle = yellowTxtBtnStyle.copyWith(color: Colors.black45);

  // ------ e.g. "Sign In"
  static TextStyle btnTextBlueUnderlineStyle = yellowTxtBtnStyle.copyWith(
    decoration: TextDecoration.underline,
    decorationThickness: 3,
    decorationColor: Styles.midnightBlue,
    color: midnightBlue,
  );
}
