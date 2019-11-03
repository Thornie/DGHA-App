import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/info_menu_card_data.dart';
import 'package:dgha_brochure/models/screen_args.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final double cardWidth;
  final double cardHeight;
  final InfoMenuCardData card;
  final int cardIndex;
  final int listLength;

  InfoCard({this.cardWidth, this.cardHeight, this.card, this.cardIndex, this.listLength});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      value: "Card $cardIndex of $listLength",
      label: card.semanticLabel,
      hint: card.semanticHint,
      excludeSemantics: true,
      explicitChildNodes: false,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            card.pageToNavigateTo,
            arguments: InfoScrArgs(title: card.pageTitle, texts: card.texts),
          );
        },
        child: Semantics(
          child: Container(
            width: this.cardWidth,
            height: this.cardHeight,
            decoration: BoxDecoration(
              color: Styles.midnightBlue,
              borderRadius: BorderRadius.all(Radius.circular(Styles.normalRadius)),
              boxShadow: [
                BoxShadow(
                  color: Styles.grey,
                  blurRadius: 3,
                  offset: Offset(2, 3),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: Styles.imageMargin),
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage(card.imagePath))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Styles.textPadding),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Styles.normalRadius), bottomRight: Radius.circular(Styles.normalRadius)),
                  ),
                  child: Text(
                    card.cardTitle,
                    style: Styles.h3Style,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
