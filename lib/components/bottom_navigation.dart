import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Styles.normalRadius),
            topRight: Radius.circular(Styles.normalRadius),
          ),
          boxShadow: [
            BoxShadow(color: Styles.grey, blurRadius: 3, offset: Offset(0, -3))
          ],
        ),
        child: Stack(
          children: <Widget>[
           DghaIcon(
             icon: FontAwesomeIcons.bars,
             backgroundColor: Colors.transparent,
             iconColor: Colors.transparent,
           ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Semantics(
                    label: this.ratingSemanticLabel,
                    excludeSemantics: true,
                    child: MaterialButton(
                      child: DghaIcon(
                        icon: FontAwesomeIcons.star,
                        iconColor: Styles.midnightBlue,
                      ),
                      onPressed: () {
                        print("Rating Pressed");
                      },
                    ),
                  ),
                ),
                Container(
                  width: 2.0,
                  color: Styles.midnightBlue,
                  height: 35,
                ),
                Expanded(
                  child: Semantics(
                    label: this.infoSemanticLabel,
                    excludeSemantics: true,
                    child: MaterialButton(
                      child: DghaIcon(
                        icon: FontAwesomeIcons.dog,
                        iconColor: Styles.midnightBlue,
                      ),
                      onPressed: () {
                        print("Info Pressed");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
