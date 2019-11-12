import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';

class ReviewCount extends StatelessWidget {
  final int numOfRating; 
  final TextStyle textStyle; 

  ReviewCount({@required this.numOfRating, @required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        // minHeight: 10,
        minWidth: 28
      ),
      decoration: BoxDecoration(
      color: Styles.yellow,
      borderRadius: BorderRadius.all(Radius.circular(1000)),
      ),
      child: Text(
        numOfRating.toString(),
        style: this.textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}