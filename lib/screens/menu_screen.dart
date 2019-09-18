import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/bottom_navigation.dart';
import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/components/menu_drawer.dart';
import 'package:dgha_brochure/components/menu_card.dart';
import 'package:dgha_brochure/misc/data.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/menu_card_data.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  static const String id = "Menu Screen";
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // used for closing or opening drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // app properties
  double scrWidth;
  double scrHeight;
  double textScale;

  // drawer properties
  double drawerWidth;

  // card properties
  bool isVertical = false;

  // the cardMinWidth is small enough that the user can see a bit of the next card
  final double cardMinWidth = 143;

  // the cardMaxHeight isn't too big, so the user doesn't need to scroll for too long
  final double cardMaxHeight = 300;

  double cardWidth;
  double cardHeight;
  double cardMaxWidth;

  // card text properties
  final double textMinWidth = 102;
  final double textMinHeight = 34;

  // sort
  bool isOrderedByAbc = false;
  List<String> sort = ['Alphabetical', 'Population'];
  double popUpHeight;
  final double popUpTextHeight = 50;
  final double popUpMaxHeight = 90;

  void calcDimensions(Orientation orientation) {
    this.scrWidth = MediaQuery.of(context).size.width;
    this.scrHeight = MediaQuery.of(context).size.height;
    this.textScale = MediaQuery.of(context).textScaleFactor;

    double cardNewMinWidth = (this.textMinWidth * this.textScale) + Styles.textPadding * 2;

    // reset card's width
    double cardNewWidth = 0;

    if (this.isVertical) {
      // cardMaxWidth = the whole screen - the padding
      double cardMaxWidth = (this.scrWidth - (Styles.spacing * 2));

      // get the number of cards that can fit on a screen
      int numOfCards = ((this.scrWidth - (Styles.spacing * 2)) / cardNewMinWidth).floor();

      // make sure that all cards are big enough to fit all the text
      while (cardNewWidth < cardNewMinWidth) {
        double scrWidthIncludingPadding = scrWidth - (Styles.spacing * 2) - (Styles.spacing * (numOfCards - 1));
        cardNewWidth = scrWidthIncludingPadding / (numOfCards);

        // better that the cards are bigger than it need to be, rather than too small
        numOfCards--;
      }

      // if the card is bigger than the whole screen, set it to cardMaxWidth
      if (cardNewWidth > cardMaxWidth) {
        cardNewWidth = cardMaxWidth;
      }
    } else {
      // the cardMaxWidth is small enough that the user can still see a bit of the next card
      double cardMaxWidth = (this.scrWidth - (Styles.spacing * 2)) * 0.85;

      cardNewWidth = cardNewMinWidth + Styles.spacing;

      // if the card is smaller than 140, it's too small
      if (cardNewWidth < this.cardMinWidth) {
        cardNewWidth = this.cardMinWidth;
      }

      // if the card is bigger than the 85% of the screen, it's too big
      if (cardNewWidth > cardMaxWidth) {
        cardNewWidth = cardMaxWidth;
      }
    }

    if (this.textScale < 1.5 || this.textScale == 1.5) {
      this.popUpHeight = this.popUpTextHeight;
    } else if (this.textScale > 1.5 && this.textScale < 2) {
      this.popUpHeight = this.popUpTextHeight * this.textScale * 0.8;
    } else if (this.textScale > 2 || this.textScale == 2) {
      this.popUpHeight = this.popUpTextHeight * this.textScale * 0.7;
    }

    this.popUpHeight = this.popUpHeight > this.popUpMaxHeight ? this.popUpMaxHeight : this.popUpHeight;

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
                      SizedBox(height: 35),

                      // -------------- GENERAL INFORMATION
                      Semantics(
                        label: "General Information Section",
                        hint: "There are ${Data.generalInfoCardData.length} cards in this section",
                        explicitChildNodes: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 45),
                            _buildH2("General Information"),
                            _buildCardsList(Data.generalInfoCardData),
                          ],
                        ),
                      ),

                      // -------------- LAWS INFORMATION
                      Semantics(
                        label: "Federal and State Laws Section",
                        hint: "There are ${Data.lawInfoCardDataABC.length} cards in this section, " +
                            (this.isVertical ? "Slide up and down to see more cards" : "Slide left and right to see more cards"),
                        explicitChildNodes: true,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: this.isVertical ? 15 : 3.3),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Expanded(child: _buildH2("Laws")),
                                buildPopUp(),
                                SizedBox(
                                  width: Styles.appBarHorizontalPadding,
                                )
                              ],
                            ),
                            _buildCardsList(this.isOrderedByAbc ? Data.lawInfoCardDataABC : Data.lawInfoCardDataPop),
                            SizedBox(height: 40),
                          ],
                        ),
                      ),
                      SizedBox(height: 70.0,)
                    ],
                  ),
                ),

                // -------------- APP BAR
                // it's at the bottom so it's above all of the other widgets
                DghaAppBar(
                  text: "DGHA",
                  isMenu: true,
                  semanticLabel: "D G H A - Guide Dog Handler Australia",
                  childOne: Semantics(
                    button: true,
                    label: "Menu",
                    hint: "Double tap to open side bar menu",
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _scaffoldKey.currentState.openDrawer();
                        });
                      },
                      child: DghaIcon(icon: FontAwesomeIcons.bars),
                    ),
                  ),
                  childTwo: Semantics(
                    button: true,
                    label: "Card Direction.",
                    hint: this.isVertical ? "Double tap to display cards horizontally." : "Double tap to display cards vertically.",
                    explicitChildNodes: false,
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
                ),
                DGHABotNav(
                  infoSemanticLabel: "Info Page",
                  ratingSemanticLabel: "Ratings Page",
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  PopupMenuButton<String> buildPopUp() {
    return PopupMenuButton(
      onSelected: (choice) {
        if (choice == "Alphabetical") {
          setState(() {
            this.isOrderedByAbc = true;
          });
        } else {
          setState(() {
            this.isOrderedByAbc = false;
          });
        }
      },
      child: Semantics(
        button: true,
        label: "Sort",
        hint: this.isOrderedByAbc ? "Sort by: alphabetical. Double tap to change the sorting." : "Sort by: population size. Double tap to change the sorting.",
        child: Container(
          padding: EdgeInsets.all(Styles.iconPaddingPadding),
          child: Container(
              padding: EdgeInsets.all(Styles.iconPadding),
              decoration: BoxDecoration(
                color: Styles.midnightBlue,
                borderRadius: BorderRadius.all(Radius.circular(1000)),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 5,),
                  Icon(
                    FontAwesomeIcons.filter,
                    size: Styles.iconSize,
                    color: Styles.yellow,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    this.isOrderedByAbc ? FontAwesomeIcons.sortAlphaDown : FontAwesomeIcons.sortAmountDown,
                    size: Styles.iconSize,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5,)
                ],
              )),
        ),
      ),
      itemBuilder: (BuildContext ctxt) {
        return this.sort.map((String order) {
          return PopupMenuItem(
            height: this.popUpHeight,
            value: order,
            child: Container(
              child: Text(
                order,
                style: Styles.h3LinkStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }).toList();
      },
    );
  }

  Widget _buildH2(String text) {
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

  List<Widget> _buildCards(List<MenuCardData> cardsData, bool isSeparated) {
    List<Widget> cards = new List<Widget>();

    for (int i = 0; i < cardsData.length; i++) {
      Widget w = MenuCard(
        card: cardsData[i],
        cardWidth: this.cardWidth,
        cardHeight: this.cardHeight,
        cardIndex: i + 1,
        listLength: cardsData.length,
      );
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
        // the 2.5 accounts for the extra padding on the top and bottom
        height: this.cardHeight + Styles.spacing * 1.5,
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(Styles.spacing, Styles.spacing / 2, Styles.spacing, Styles.spacing),
          scrollDirection: Axis.horizontal,
          children: this._buildCards(cardsData, true),
        ),
      );
    }
  }
}
