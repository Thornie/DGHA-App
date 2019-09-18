import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';

class DGHABotNav extends StatelessWidget {
  final String infoSemanticLabel;
  final String ratingSemanticLabel;

  DGHABotNav({this.infoSemanticLabel, this.ratingSemanticLabel});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.maxFinite,
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Styles.normalRadius),
            topRight: Radius.circular(Styles.normalRadius),
          ),
          boxShadow: [
            BoxShadow(color: Styles.grey, blurRadius: 3, offset: Offset(0, 3))
          ],
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Semantics(
                label: this.ratingSemanticLabel,
                excludeSemantics: true,
                child: MaterialButton(
                  child: Text("Ratings"),
                  onPressed: () {
                    print("Rating Pressed");
                  },
                ),
              ),
            ),
            Expanded(
              child: Semantics(
                label: this.infoSemanticLabel,
                excludeSemantics: true,
                child: MaterialButton(
                  child: Text("Info"),
                  onPressed: () {
                    print("Info Pressed");
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
