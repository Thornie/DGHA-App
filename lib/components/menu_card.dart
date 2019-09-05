import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/menu_card_data.dart';
import 'package:dgha_brochure/models/screen_args.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final MenuCardData card; 
  final double width;
  final EdgeInsets margin;

  MenuCard({this.card, this.width, this.margin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(card.pageToNavigateTo,
            arguments:
                ScreenArguments(title: card.pageTitle, texts: card.texts));
      },
      child: Container(
        width: this.width,
        margin: this.margin,
        decoration: BoxDecoration(
            color: Styles.midnightBlue,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [Styles.customBoxShadow(Offset(1, 2))]),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: this.width / 2.8, top: this.width/18),
              decoration: card.imagePath == "" ? BoxDecoration() : BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(card.imagePath),
                      fit: BoxFit.contain)),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: double.maxFinite,
              height: this.width/3.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  card.title,
                  style: Styles.h2TextStyle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
