import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';

class DghaAppBar extends StatelessWidget {
  final double srcWidth;
  final double appBarHeight;
  final double horizontalPadding;
  final Widget leftChild;
  final Widget rightChid;
  final String text;
  final double borderRadius;
  final bool isMenuScr;

  DghaAppBar(
      {this.srcWidth, this.appBarHeight, this.horizontalPadding, this.leftChild, this.text, this.rightChid, this.borderRadius, this.isMenuScr});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.srcWidth,
      height: this.appBarHeight,
      margin: EdgeInsets.only(bottom: 3),
      padding: EdgeInsets.symmetric(horizontal: Styles.appBarHorizontalPadding),
      constraints: BoxConstraints(minHeight: 70, maxHeight: 125),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(this.borderRadius), bottomRight: Radius.circular(this.borderRadius)),
          boxShadow: [BoxShadow(color: Styles.grey, blurRadius: 3, offset: Offset(0, 3))]),
      child: Row(
        children: <Widget>[
          this.leftChild,
          Expanded(
            child: Semantics(
              label: "Title",
              hint: "D G H A. Dog Guide Handler Australia",
              child: Container(
                // color: Colors.blue,
                padding: EdgeInsets.all(this.appBarHeight / 8),
                child: Text(
                  this.text,
                  style: isMenuScr ? Styles.h1Style : Styles.h2Style,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          this.rightChid
        ],
      ),
    );
  }
}
