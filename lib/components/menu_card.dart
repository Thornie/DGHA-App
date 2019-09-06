import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/menu_card_data.dart';
import 'package:dgha_brochure/models/screen_args.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final MenuCardData card; 
  final double radius;
  final double margin;

  MenuCard({this.card, this.radius, this.margin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(card.pageToNavigateTo,
            arguments:
                ScreenArguments(title: card.pageTitle, texts: card.texts));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Styles.midnightBlue,
            borderRadius:
                BorderRadius.all(Radius.circular(radius)),
            boxShadow: [
              Styles.customBoxShadow(Offset(1, 2))
            ]),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: AspectRatio(
                aspectRatio: 1.18,
                child: Container(
                  margin: EdgeInsets.all(margin),
                  decoration: card.imagePath != "" ? BoxDecoration(
                    image: DecorationImage(image: AssetImage(card.imagePath))
                  ) : BoxDecoration(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AspectRatio(
                aspectRatio: 3.7,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      10, 5, 10, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft:
                            Radius.circular(radius),
                        bottomRight:
                            Radius.circular(radius)),
                  ),
                  child: Center(
                      child: Styles.buildH3(
                          card.shortTitle)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
