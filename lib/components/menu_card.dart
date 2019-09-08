import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/menu_card_data.dart';
import 'package:dgha_brochure/models/screen_args.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final double width;
  final double height;
  final double maxHeight;
  final double radius;
  final MenuCardData card;

  MenuCard({this.width, this.radius, this.height, this.maxHeight, this.card});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(card.pageToNavigateTo, arguments: ScreenArguments(title: card.pageTitle, texts: card.texts));
      },
      child: Container(
        width: this.width,
        margin: EdgeInsets.only(bottom: 7),
        decoration: BoxDecoration(
          color: Styles.midnightBlue,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          boxShadow: [
            BoxShadow(
              color: Styles.grey,
              blurRadius: 3,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  Container(
                    width: width,
                    height: height * 0.023,
                    constraints: BoxConstraints(maxHeight: maxHeight * 0.4),
                  ),
                  Container(
                    width: width,
                    height: height * 0.65,
                    constraints: BoxConstraints(maxHeight: maxHeight * 0.62),
                    decoration: card.imagePath != "" ? BoxDecoration(image: DecorationImage(image: AssetImage(card.imagePath))) : BoxDecoration(),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: width,
                height: height * 0.3,
                constraints: BoxConstraints(maxHeight: maxHeight * 0.3),
                padding: EdgeInsets.all(width * 0.025),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))),
                child: Center(
                  child: Text(
                    card.shortTitle,
                    style: Styles.h3Style
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
