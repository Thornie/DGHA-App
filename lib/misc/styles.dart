import 'package:flutter/material.dart';

class Styles {
  // ----------------- COLOURS
  static final Color yellow = Color(0xfffae100);
  static final Color midnightBlue = Color(0xff00205b);
  static final Color grey = Color(0xff576a80);
  static final Color transparent = Color(0x00000000);

  // ----------------- SIZES
  // ---------- APP
  static final double appBarHorizontalPadding = 10; 

  // ---------- ICON
  static double iconSize = 24; 
  static final double iconPadding = 10; 
  static final double iconPaddingPadding = 10; 
  

  // ----------------- GENERAL TEXT
  static TextStyle h1Style = TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w900, fontSize: 32);   // DGHA
  static TextStyle h2Style = TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w700, fontSize: 24);   // Geneneral Info
  static TextStyle h3Style = TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w600, fontSize: 20);   // Federal
  static TextStyle h3LinkStyle = TextStyle(fontFamily: "Manjari", fontWeight: FontWeight.w700, fontSize: 20);   // Links
  static TextStyle pStyle = TextStyle(fontFamily: "Manjari", fontWeight: FontWeight.w700, fontSize: 18);    // Normal Text
}
