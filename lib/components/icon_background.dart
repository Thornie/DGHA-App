import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';

class IconBackground extends StatelessWidget {
  final Widget child; 

  IconBackground({this.child}); 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
          color: Styles.midnightBlue,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: child
    );
  }
}
