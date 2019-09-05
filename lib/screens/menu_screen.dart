import 'package:dgha_brochure/components/icon_background.dart';
import 'package:dgha_brochure/components/menu_drawer.dart';
import 'package:dgha_brochure/components/menu_card.dart';
import 'package:dgha_brochure/components/menu_heading.dart';
import 'package:dgha_brochure/misc/data.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuScreen extends StatefulWidget {
  static const String id = "Menu Screen";
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double srcWidth = MediaQuery.of(context).size.width;
    double srcHeight = MediaQuery.of(context).size.height;
    srcHeight = srcHeight - (srcHeight / 5);
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuDrawer(),
      body: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
          return Column(
            children: <Widget>[
              // NOTE: AppBar
              Container(
                padding: EdgeInsets.fromLTRB(0, 13, 0, 13),
                margin: EdgeInsets.only(bottom: 2),
                decoration: Styles.customAppBarBoxDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: IconBackground(
                        child: IconButton(
                          icon: Styles.buildIcon(FontAwesomeIcons.bars),
                          onPressed: () {
                            setState(() {
                              _scaffoldKey.currentState.openDrawer();
                            });
                          },
                        ),
                      ),
                    ),
                    Text(
                      "DGHA",
                      style: Styles.customAppBartextStyle,
                    ),
                    SizedBox(
                      width: 50,
                    )
                  ],
                ),
              ),

              // NOTE: The Scrollable List Tiles Section
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                      physics: orientation == Orientation.portrait
                          ? NeverScrollableScrollPhysics()
                          : BouncingScrollPhysics(),
                      child: Container(
                        height: orientation == Orientation.portrait
                            ? srcHeight
                            : srcHeight * 1.5,
                        child: Column(
                          children: <Widget>[
                            // NOTE: General Information
                            SizedBox(
                              height: orientation == Orientation.portrait
                                  ? srcHeight / 15
                                  : srcHeight / 20,
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  InfoMenuHeading(
                                    text: "General Information",
                                  ),
                                  Expanded(
                                    child: Container(
                                        margin:
                                            EdgeInsets.only(left: 30, top: 10),
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics: BouncingScrollPhysics(),
                                          itemCount:
                                              Data.generalInfoCardData.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            EdgeInsets margin = index == 0
                                                ? EdgeInsets.fromLTRB(
                                                    0, 0, 0, 5)
                                                : EdgeInsets.fromLTRB(
                                                    20, 0, 0, 5);
                                            return MenuCard(
                                                card: Data
                                                    .generalInfoCardData[index],
                                                width: orientation ==
                                                        Orientation.portrait
                                                    ? srcWidth / 2.8
                                                    : srcWidth / 4.5,
                                                margin: margin);
                                          },
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: orientation == Orientation.portrait
                                  ? srcHeight / 15
                                  : srcHeight / 20,
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    InfoMenuHeading(
                                        text: "Federal and State Laws"),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics: BouncingScrollPhysics(),
                                          itemCount:
                                              Data.lawInfoCardData.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            EdgeInsets margin;
                                            if (index == 0) {
                                              margin = EdgeInsets.fromLTRB(
                                                  30, 0, 0, 5);
                                            } else if (index ==
                                                Data.lawInfoCardData.length -
                                                    1) {
                                              margin = EdgeInsets.fromLTRB(
                                                  20, 0, 30, 5);
                                            } else {
                                              margin = EdgeInsets.fromLTRB(
                                                  20, 0, 0, 5);
                                            }
                                            return MenuCard(
                                                card:
                                                    Data.lawInfoCardData[index],
                                                width: orientation ==
                                                        Orientation.portrait
                                                    ? srcWidth / 2.8
                                                    : srcWidth / 4.5,
                                                margin: margin);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: srcHeight / 13
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
