import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/components/menu_drawer.dart';
import 'package:dgha_brochure/components/menu_card.dart';
import 'package:dgha_brochure/misc/data.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/menu_card_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  static const String id = "Menu Screen";
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // NOTE: App Properties
  double scrWidth;
  double scrHeight;
  double textScale;

  // NOTE: Drawer
  double drawerWidth;

  // NOTE: Card Properties
  bool isVertical = false;

  double cardMinWidth = 143;
  double cardMaxHeight = 300;
  double cardWidth;
  double cardHeight;
  double cardMaxWidth;

  // NOTE: Card Text
  final double textMinWidth = 102;
  final double textMinHeight = 34;

  void calcDimensions(Orientation orientation) {
    this.scrWidth = MediaQuery.of(context).size.width;
    this.scrHeight = MediaQuery.of(context).size.height;
    this.textScale = MediaQuery.of(context).textScaleFactor;

    double cardNewMinWidth = (this.textMinWidth * this.textScale) + Styles.textPadding * 2;
    double cardNewWidth = 0;

    if (isVertical) {
      double cardMaxWidth = (this.scrWidth - (Styles.spacing * 2));
      int numOfCards = ((this.scrWidth - (Styles.spacing * 2)) / cardNewMinWidth).floor();

      while (cardNewWidth < cardNewMinWidth) {
        double scrWidthIncludingPadding = scrWidth - (Styles.spacing * 2) - (Styles.spacing * (numOfCards - 1));
        cardNewWidth = scrWidthIncludingPadding / (numOfCards);
        numOfCards--;
      }

      // set max width
      if (cardNewWidth > cardMaxWidth) {
        cardNewWidth = cardMaxWidth;
      }
    } else {
      double cardMaxWidth = (this.scrWidth - (Styles.spacing * 2)) * 0.85;
      cardNewWidth = cardNewMinWidth + Styles.spacing;

      // set min width
      if (cardNewWidth < this.cardMinWidth) {
        cardNewWidth = this.cardMinWidth;
      }

      // set max width
      if (cardNewWidth > cardMaxWidth) {
        cardNewWidth = cardMaxWidth;
      }
    }

    this.drawerWidth = orientation == Orientation.portrait ? this.scrWidth * 0.75 : this.scrHeight * 0.75;
    this.cardWidth = cardNewWidth;
    this.cardHeight = this.cardWidth * 1.15;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuDrawer(
        width: this.drawerWidth,
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            this.calcDimensions(orientation);
            return Stack(
              children: <Widget>[
                Container(
                  height: this.scrHeight,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      SizedBox(height: 105),
                      _buildH2("General Information"),
                      _buildCardsList(Data.generalInfoCardData),
                      SizedBox(height: isVertical ? 40 : 0),
                      _buildH2("Law"),
                      _buildCardsList(Data.lawInfoCardData),
                      SizedBox(height: 40),
                    ],
                  ),
                ),

                // APP BAR
                DghaAppBar(
                  childOne: Container(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _scaffoldKey.currentState.openDrawer();
                        });
                      },
                      child: DghaIcon(
                        icon: FontAwesomeIcons.bars,
                      ),
                    ),
                  ),
                  childTwo: Container(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          this.isVertical = !this.isVertical;
                        });
                      },
                      child: DghaIcon(
                        icon: this.isVertical ? FontAwesomeIcons.arrowsAltH : FontAwesomeIcons.arrowsAltV,
                      ),
                    ),
                  ),
                  text: "DGHA",
                  isMenu: true,
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildH2(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Styles.spacing),
      child: Text(
        text,
        style: Styles.h2Style,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // VERTICAL
  List<Widget> _buildCards(List<MenuCardData> cardsData, bool isSeparated) {
    List<Widget> cards = new List<Widget>();

    for (int i = 0; i < cardsData.length; i++) {
      Widget w = MenuCard(card: cardsData[i], cardWidth: this.cardWidth, cardHeight: this.cardHeight);
      cards.add(w);

      if ((isSeparated) && (i < cardsData.length - 1)) {
        Widget separator = SizedBox(width: Styles.spacing);
        cards.add(separator);
      }
    }
    return cards;
  }

  Widget _buildCardsList(List<MenuCardData> cardsData) {
    if (this.isVertical) {
      return Padding(
        padding: EdgeInsets.fromLTRB(Styles.spacing, 10, Styles.spacing, 0),
        child: Wrap(
          spacing: Styles.spacing,
          runSpacing: Styles.spacing,
          children: this._buildCards(cardsData, false),
        ),
      );
    } else {
      return Container(
        height: this.cardHeight + Styles.spacing * 2.5,
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(Styles.spacing, Styles.spacing / 2, Styles.spacing, Styles.spacing * 2),
          scrollDirection: Axis.horizontal,
          children: this._buildCards(cardsData, true),
        ),
      );
    }
  }
}
