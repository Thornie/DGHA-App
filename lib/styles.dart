import 'package:flutter/material.dart';

class DGHAColours {
  static const textColour = Color(0xff25211f);
}

class DGHAStyles {
  static TextStyle titleStyle(Color textColour) {
    return TextStyle(
      fontFamily: 'JosefinSans',
      fontWeight: FontWeight.w700,
      fontSize: 26,
      color: textColour,
    );
  }

  static TextStyle paragraphTextStyle(Color textColor) {
    return TextStyle(
      fontFamily: 'OpenSans',
      color: textColor,
      fontSize: 18,
    );
  }

  static BoxDecoration boxDeco(Color containerColour, Color shadowColour) {
    return BoxDecoration(
      color: containerColour,
      borderRadius: new BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        new BoxShadow(color: shadowColour, offset: new Offset(10, 10))
      ],
    );
  }
}
