import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';

class IconBg extends StatelessWidget {
  final double height; 
  final Widget chid; 

  IconBg({this.height, this.chid});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height * 0.73,
      height: height * 0.7,
      constraints: BoxConstraints(minHeight: 50, maxHeight: 100),
      decoration: BoxDecoration(color: Styles.midnightBlue, borderRadius: BorderRadius.all(Radius.circular(1000))),
      child: this.chid
    );
  }
}