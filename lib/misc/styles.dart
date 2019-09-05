import 'package:flutter/material.dart';

class Styles {
  // ----------------- COLOURS
  static final Color yellow = Color(0xfffad00c);
  static final Color transparent = Color(0x00000000);

  // ----------------- APP BAR
  static final EdgeInsets customAppBarPadding = EdgeInsets.only(right: 10, bottom: 5, top: 10);

  static final BoxDecoration customAppBarBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
    boxShadow: [customBoxShadow(Offset(0, 1))],
  );

  static final TextStyle customAppBartextStyle = TextStyle(
    fontFamily: "RedHatText",
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: Color(0xff102d4d),
  );

  // ----------------- GENERAL TEXT
  static TextStyle pTextStyle = TextStyle(
    fontFamily: "Manjari",
    fontSize: 20,
    color: Color(0xff102d4d),
  );

  static TextStyle h1TextStyle = TextStyle(
    fontFamily: "RedHatText", 
    fontSize: 20, 
    fontWeight: FontWeight.w500,
  );
  
  static TextStyle h2TextStyle = TextStyle(
    fontFamily: "Manjari",
    fontSize: 20,
    fontWeight: FontWeight.w700
  ); 

  // ----------------- ICON
  static Icon buildIcon(IconData icon, Color colour) {
    return Icon(icon, color: colour, size: 30);
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
