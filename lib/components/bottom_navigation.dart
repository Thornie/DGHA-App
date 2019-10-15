import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/screens/menu_screen.dart';
import 'package:dgha_brochure/screens/rating_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DGHABotNav extends StatelessWidget {
  final Color activeTabColor;
  // 0 for ratings tab
  // 1 for dog info tab 
  final int activeTab;

  DGHABotNav({this.activeTabColor, this.activeTab});

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
              // -------------------- Rating Button
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: this.activeTab == 0
                          ? this.activeTabColor
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Styles.normalRadius),
                      ),
                    ),
                    child: Semantics(
                      label: "Rating Page",
                      hint: "Double tap to go to the rating page",
                      excludeSemantics: true,
                      child: MaterialButton(
                        child: DghaIcon(
                          icon: FontAwesomeIcons.solidStar,
                          iconColor: Styles.midnightBlue,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(RatingMenuScreen.id);
                        },
                      ),
                    ),
                  ),
                ),
                // -------------------- Middle Line
                Container(
                  width: 2.0,
                  color: Styles.midnightBlue,
                  height: 35,
                ),
                // -------------------- Dog Info Button
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: this.activeTab == 1
                          ? this.activeTabColor
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Styles.normalRadius),
                      ),
                    ),
                    child: Semantics(
                      label: "Information Page",
                      hint: "Double tap to go to the information page",
                      excludeSemantics: true,
                      child: MaterialButton(
                        child: DghaIcon(
                          icon: FontAwesomeIcons.dog,
                          iconColor: Styles.midnightBlue,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(MenuScreen.id);
                        },
                      ),
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