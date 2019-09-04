import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/languages.dart';
import 'package:dgha_brochure/models/screen_args.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final double width;
  final EdgeInsets margin;
  final Color colour;
  final String pageToNavigateTo;
  final List<Language> texts;
  final String pageTitle;

  MenuCard(
      {this.title,
      this.width,
      this.margin,
      this.colour,
      this.pageToNavigateTo,
      this.texts,
      this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(this.pageToNavigateTo,
            arguments: ScreenArguments(title: this.pageTitle, texts: this.texts));
      },
      child: Container(
        width: this.width,
        margin: this.margin,
        decoration: BoxDecoration(
            color: Color(0xfffad00c),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [Styles.customBoxShadow(Offset(1, 2))]),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(),
            Container(
              padding: EdgeInsets.all(10),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Text(
                this.title,
                textAlign: TextAlign.center,
                style: Styles.h2TextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
