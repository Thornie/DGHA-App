import 'package:dgha_brochure/components/menu_drawer.dart';
import 'package:dgha_brochure/components/menu_card.dart';
import 'package:dgha_brochure/components/menu_heading.dart';
import 'package:dgha_brochure/misc/data.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';

class PageViewMenu extends StatefulWidget {
  static const String id = "Page View Menu";
  @override
  _PageViewMenuState createState() => _PageViewMenuState();
}

class _PageViewMenuState extends State<PageViewMenu> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuDrawer(),
      body: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
          return Column(
            children: <Widget>[
              // NOTE: AppBar
              Container(
                padding: Styles.customAppBarPadding,
                margin: EdgeInsets.only(bottom: 2),
                decoration: Styles.customAppBarBoxDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.only(left: 30),
                      icon: Styles.buildIcon(Icons.menu, Styles.yellow),
                      onPressed: () {
                        setState(() {
                          _scaffoldKey.currentState.openDrawer();
                        });
                      },
                    ),
                    Text(
                      "DGHA",
                      style: Styles.customAppBartextStyle,
                    ),
                    SizedBox(
                      width: 35,
                    )
                  ],
                ),
              ),

              // NOTE: The Scrollable List Tiles Section
              Expanded(
                child: SingleChildScrollView(
                  physics: orientation == Orientation.portrait ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
                    child: Column(
                  children: <Widget>[

                    // NOTE: General Information
                    Container(
                      margin: orientation == Orientation.portrait ? EdgeInsets.only(top: 40) : EdgeInsets.only(top: 20),
                      child: Column(
                        children: <Widget>[
                          InfoMenuHeading( text: "General Information"),
                          Container(
                            height: 160,
                            padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: Data.generalInfoCardData.length,
                              itemBuilder: (BuildContext context, int index) {
                                EdgeInsets margin = index == 0 ? EdgeInsets.fromLTRB(0, 0, 0, 5) : EdgeInsets.fromLTRB(20, 0, 0, 5);
                                return MenuCard(
                                  title: Data.generalInfoCardData[index].title,
                                  width: 125,
                                  margin: margin,
                                  colour: Data.generalInfoCardData[index].colour,
                                  pageToNavigateTo: Data.generalInfoCardData[index].pageToNavigateTo,
                                  texts: Data.generalInfoCardData[index].texts,
                                  pageTitle: Data.generalInfoCardData[index].pageTitle,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),

                    // NOTE: Laws
                    Container(
                      margin: orientation == Orientation.portrait ? EdgeInsets.only(top: 30, bottom: 40) : EdgeInsets.only(top: 15, bottom: 25),
                      child: Column(
                        children: <Widget>[
                          InfoMenuHeading( text: "Federal and State Laws"),
                          Container(
                            height: 160,
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: Data.lawInfoCardData.length,
                              itemBuilder: (BuildContext context, int index) {
                                EdgeInsets margin;
                                if (index == 0) {
                                  margin = EdgeInsets.fromLTRB(30, 0, 0, 5);
                                } else if (index == Data.lawInfoCardData.length - 1) {
                                  margin = EdgeInsets.fromLTRB(20, 0, 30, 5);
                                } else {
                                  margin = EdgeInsets.fromLTRB(20, 0, 0, 5);
                                }
                                return MenuCard(
                                  title: Data.lawInfoCardData[index].title,
                                  width: 125,
                                  margin: margin,
                                  colour: Data.lawInfoCardData[index].colour,
                                  pageToNavigateTo: Data.lawInfoCardData[index].pageToNavigateTo,
                                  texts: Data.lawInfoCardData[index].texts,
                                  pageTitle: Data.lawInfoCardData[index].pageTitle,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
              ),
            ],
          );
        }),
      ),
    );
  }
}
