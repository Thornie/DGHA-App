import 'package:dgha/misc/styles.dart';
import 'package:flutter/material.dart';

class YellowTagHighlight extends StatelessWidget {
  final String text; 
  final TextStyle textStyle; 

  YellowTagHighlight({@required this.text, @required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        // minHeight: 10,
        minWidth: 28
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
      color: Styles.yellow,
      borderRadius: BorderRadius.all(Radius.circular(1000)),
      ),
      child: Text(
        text.toString(),
        style: this.textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}