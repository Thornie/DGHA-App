import 'package:flutter/material.dart';

class Styles {
  // ----------------- COLOURS
  static final Color yellow = Color(0xfffae100);
  static final Color midnightBlue = Color(0xff00205b);
  static final Color transMidnightBlue = Color(0x7000205b);
  static final Color grey = Color(0xff576a80);
  static final Color transparent = Color(0x00000000);
  static final Color softGrey = Color(0xfff2f5f8);

  // ----------------- SIZES
  // ---------- APP
  static final double appBarHorizontalPadding = 10;
  static final double normalRadius = 20;
  static final double imageMargin = 8;
  static final double spacing = 20;
  // ---------- TEXT
  static final double textPadding = 10;
  // ---------- ICON
  static double iconSize = 24;
  static final double iconPadding = 10;
  static final double iconPaddingPadding = 10;

  // ----------------- GENERAL TEXT
  static TextStyle h1Style = TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w900, fontSize: 32, color: midnightBlue); // DGHA
  static TextStyle h2Style = TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w700, fontSize: 24, color: midnightBlue); // Geneneral Info
  static TextStyle h3Style = TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w600, fontSize: 20, color: midnightBlue); // Cards Text
  static TextStyle h4Style = TextStyle(fontFamily: "Manjari", fontWeight: FontWeight.w700, fontSize: 18, backgroundColor: yellow, color: midnightBlue);
  static TextStyle h3LinkStyle = TextStyle(fontFamily: "Manjari", fontWeight: FontWeight.w700, fontSize: 20, color: midnightBlue); // Drawer Tiles
  static TextStyle pStyle = TextStyle(fontFamily: "Manjari", fontWeight: FontWeight.w700, fontSize: 18, color: midnightBlue); // Normal Text
  static TextStyle linkStyle =
      TextStyle(fontFamily: "Manjari", fontWeight: FontWeight.w700, fontSize: 18, backgroundColor: yellow, color: midnightBlue, decoration: TextDecoration.underline, decorationColor: midnightBlue);
  static TextStyle highlightText = TextStyle(fontFamily: "Manjari", fontWeight: FontWeight.w700, fontSize: 18, backgroundColor: yellow, color: midnightBlue);
  static TextStyle searchStyle = TextStyle(fontFamily: "Poppins", fontSize: 18, color: midnightBlue);
}
