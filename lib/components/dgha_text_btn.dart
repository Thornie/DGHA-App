import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';

class DghaTextButton extends StatelessWidget {
  final double minWidth;
  final String text;
  final TextStyle textStyle;
  final Function() onTap;
  final Color colour;
  final double bottomMargin;

  DghaTextButton({this.onTap, this.minWidth, this.text, this.colour, this.textStyle, this.bottomMargin = 0});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          constraints: BoxConstraints(minWidth: this.minWidth),
          padding: EdgeInsets.symmetric(vertical: 10),
          margin: EdgeInsets.only(bottom: this.bottomMargin),
          decoration: BoxDecoration(
            color: this.colour,
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(color: Styles.grey, blurRadius: 3, offset: Offset(2, 3)),
            ],
          ),
          child: Text(this.text, textAlign: TextAlign.center, style: this.textStyle),
        ),
      ),
    );
  }
}
