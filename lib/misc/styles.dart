import 'package:flutter/material.dart';

class Styles {
  // ----------------- COLOURS
  static final Color yellow = Color(0xfffad000);
  static final Color midnightBlue = Color(0xff142e4c);
  static final Color transparent = Color(0x00000000);

  // ----------------- APP BAR
  static final EdgeInsets customAppBarPadding = EdgeInsets.only(bottom: 10, top: 10);

  static final BoxDecoration customAppBarBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(23)),
    boxShadow: [customBoxShadow(Offset(0, 1))],
  );

  static final TextStyle customAppBartextStyle = TextStyle(
    fontFamily: "RedHatText",
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: midnightBlue,
  );

  // ----------------- GENERAL TEXT
  static TextStyle pTextStyle = TextStyle(
    fontFamily: "Manjari",
    fontSize: 20,
    color: midnightBlue,
  );

  static TextStyle h1TextStyle = TextStyle(
    fontFamily: "RedHatText", 
    fontSize: 20, 
    fontWeight: FontWeight.w500,
    color: midnightBlue
  );
  
  static TextStyle h2TextStyle = TextStyle(
    fontFamily: "Manjari",
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: midnightBlue
  ); 

  // ----------------- ICON
  static Icon buildIcon(IconData icon) {
    return Icon(icon, color: yellow, size: 25);
  }

  // ----------------- MISC
  static BoxShadow customBoxShadow(Offset offset) {
    return BoxShadow(
      color: Color(0xff576a80),
      blurRadius: 2,
      offset: offset,
    );
  }
}
