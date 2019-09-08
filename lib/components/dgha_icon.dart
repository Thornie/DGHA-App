import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';

class DghaIcon extends StatelessWidget {
  final IconData icon; 
  
  DghaIcon({this.icon}); 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Styles.iconPaddingPadding),
          child: Container(
        padding: EdgeInsets.all(Styles.iconPadding),
        decoration: BoxDecoration(color: Styles.midnightBlue, borderRadius: BorderRadius.all(Radius.circular(1000))),
        child: Icon(
          this.icon, 
          size: Styles.iconSize,
          color: Styles.yellow,
        ),
      ),
    );
  }
}