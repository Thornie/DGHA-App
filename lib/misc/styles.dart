import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Styles {
  // ----------------- Aspect Ratio
  static final double appBarAspectRatioPort = 5 / 1;
  static final double appBarAspectRatioLand = 9.5 / 1;
  // static final double iconBgWidthPort = 


  static final double menuCardAspectRatio = 0.35;

  // ----------------- COLOURS
  static final Color yellow = Color(0xfffae100);
  static final Color midnightBlue = Color(0xff00205b);
  static final Color transparent = Color(0x00000000);

  // ----------------- APP BAR
  static final EdgeInsets customAppBarPadding =
      EdgeInsets.only(bottom: 10, top: 10);

  static final BoxDecoration customAppBarBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(20), bottomLeft: Radius.circular(23)),
    boxShadow: [customBoxShadow(Offset(0, 1))],
  );

  static final TextStyle customAppBartextStyle = TextStyle(
    fontFamily: "RedHatText",
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: midnightBlue,
  );

  // ----------------- GENERAL TEXT
  static AutoSizeText buildH1(String text) {
    return AutoSizeText(
      text,
      style: TextStyle(
          fontFamily: "RedHatText",
          fontSize: 35,
          fontWeight: FontWeight.w700,
          color: midnightBlue),
      maxLines: 1,
      minFontSize: 20,
      textAlign: TextAlign.center,
    );
  }

  static AutoSizeText buildH2(String text) {
    return AutoSizeText(
      text,
      style: TextStyle(
          fontFamily: "RedHatText",
          fontSize: 28,
          fontWeight: FontWeight.w500,
          color: midnightBlue),
      maxLines: 1,
      minFontSize: 20,
    );
  }

  static AutoSizeText buildH3(String txt1) {
    return AutoSizeText(
      txt1,
      minFontSize: 20,
      maxLines: 1,
      style: TextStyle(
        fontFamily: "Manjari",
        fontSize: 26,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  static TextStyle pTextStyle = TextStyle(
    fontFamily: "Manjari",
    fontSize: 24,
    color: midnightBlue,
    fontWeight: FontWeight.w700
  );

  static TextStyle h1TextStyle = TextStyle(
      fontFamily: "RedHatText",
      fontSize: 50,
      fontWeight: FontWeight.w700,
      color: midnightBlue);

  static TextStyle h2TextStyle = TextStyle(
      fontFamily: "Manjari",
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: midnightBlue);

  // ----------------- ICON

  // ----------------- MISC
  static BoxShadow customBoxShadow(Offset offset) {
    return BoxShadow(
      color: Color(0xff576a80),
      blurRadius: 2,
      offset: offset,
    );
  }
}
