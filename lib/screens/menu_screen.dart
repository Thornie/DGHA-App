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

  void calcDimensions(Orientation orientation) {
    this.scrWidth = MediaQuery.of(context).size.width;
    this.scrHeight = MediaQuery.of(context).size.height;
    this.textScale = MediaQuery.of(context).textScaleFactor;

    double cardNewMinWidth =
        (this.textMinWidth * this.textScale) + Styles.textPadding * 2;

    // reset card's width
    double cardNewWidth = 0;

    // cardMaxWidth = the whole screen - the padding
    double cardMaxWidth = (this.scrWidth - (Styles.spacing * 2));

    // get the number of cards that can fit on a screen
    int numOfCards =
        ((this.scrWidth - (Styles.spacing * 2)) / cardNewMinWidth).floor();

    // make sure that all cards are big enough to fit all the text
    while (cardNewWidth < cardNewMinWidth) {
      double scrWidthIncludingPadding =
          scrWidth - (Styles.spacing * 2) - (Styles.spacing * (numOfCards - 1));
      cardNewWidth = scrWidthIncludingPadding / (numOfCards);

      // better that the cards are bigger than it need to be, rather than too small
      numOfCards--;
    }

    // if the card is bigger than the whole screen, set it to cardMaxWidth
    if (cardNewWidth > cardMaxWidth) {
      cardNewWidth = cardMaxWidth;
    }

    this.drawerWidth = orientation == Orientation.portrait
        ? this.scrWidth * 0.75
        : this.scrHeight * 0.75;
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
                        hint:
                            "There are ${Data.generalInfoCardData.length} cards in this section",
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
                        hint:
                            "There are ${Data.lawInfoCardDataABC.length} cards in this section, Slide up and down to see more cards",
                        explicitChildNodes: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 15),
                            _buildH2("Laws"),
                            _buildCardsList(Data.lawInfoCardDataABC),
                            SizedBox(height: 40),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                      )
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
                      child: DghaIcon(
                        icon: FontAwesomeIcons.bars,
                        backgroundColor: Styles.midnightBlue,
                        iconColor: Styles.yellow,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      // -------------- Bottom Navigation
      bottomNavigationBar: DGHABotNav(activeTab: ActivePageEnum.infoPage),
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
    return Padding(
      padding: EdgeInsets.fromLTRB(Styles.spacing, 10, Styles.spacing, 0),
      child: Wrap(
        spacing: Styles.spacing,
        runSpacing: Styles.spacing,
        children: this._buildCards(cardsData, false),
      ),
    );
  }
}
