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
        child: Column(
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
                    icon: Styles.buildAppBarIcon(Icons.menu),
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
            // NOTE : Main body of the card list
            Expanded(
              child: Column(
                children: <Widget>[
                  // NOTE: General Information Section
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        InfoMenuHeading(text: "General Information", topMargin: 20,),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 45),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Data.generalInfoCardData.length,
                              itemBuilder: (BuildContext context, int index) {
                                EdgeInsets margin; 
                                if(index == 0) {
                                  margin = EdgeInsets.fromLTRB(0, 0, 0, 5);
                                } else {
                                  margin = EdgeInsets.fromLTRB(20, 0, 0, 5); 
                                }
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  // NOTE: Laws Section
                  Expanded(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          InfoMenuHeading(text: "Federal and State Laws", topMargin: 0,),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 65),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: Data.lawInfoCardData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  EdgeInsets margin; 
                                  if(index == 0) {
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
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
