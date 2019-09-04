import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';

class InfoMenuHeading extends StatelessWidget {
  final String text; 
  final double topMargin; 
  
  InfoMenuHeading({this.text, this.topMargin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: this.topMargin),
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 30),
      child: Text(
        this.text,
        style: Styles.h1TextStyle,
      ),
    );
  }
}