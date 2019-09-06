import 'package:auto_size_text/auto_size_text.dart';
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
  bool isHorizontal = true;

  @override
  Widget build(BuildContext context) {
    double srcWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuDrawer(),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: orientation == Orientation.portrait
                      ? Styles.appBarAspectRatioPort
                      : Styles.appBarAspectRatioLand,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: orientation == Orientation.portrait
                                ? Radius.circular(srcWidth / 15)
                                : Radius.circular(srcWidth / 25),
                            bottomRight: orientation == Orientation.portrait
                                ? Radius.circular(srcWidth / 15)
                                : Radius.circular(srcWidth / 25)),
                        boxShadow: [Styles.customBoxShadow(Offset(0, 2))]),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: orientation == Orientation.portrait
                                  ? 30
                                  : 50),
                          width: orientation == Orientation.portrait
                              ? srcWidth / 7
                              : srcWidth / 13,
                          height: orientation == Orientation.portrait
                              ? srcWidth / 7
                              : srcWidth / 13,
                          decoration: BoxDecoration(
                              color: Styles.midnightBlue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: IconButton(
                            icon: Icon(
                              FontAwesomeIcons.bars,
                              size: orientation == Orientation.portrait
                                  ? srcWidth / 12
                                  : srcWidth / 21,
                              color: Styles.yellow,
                            ),
                            onPressed: () {
                              setState(() {
                                _scaffoldKey.currentState.openDrawer();
                              });
                            },
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Styles.buildH1("DGHA"),
                            )),
                        Container(
                          margin: EdgeInsets.only(
                              right: orientation == Orientation.portrait
                                  ? 30
                                  : 50),
                          width: orientation == Orientation.portrait
                              ? srcWidth / 7
                              : srcWidth / 13,
                          height: orientation == Orientation.portrait
                              ? srcWidth / 7
                              : srcWidth / 13,
                          decoration: BoxDecoration(
                              color: Styles.midnightBlue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: IconButton(
                            icon: Icon(
                              isHorizontal
                                  ? FontAwesomeIcons.gripVertical
                                  : FontAwesomeIcons.gripHorizontal,
                              size: orientation == Orientation.portrait
                                  ? srcWidth / 12
                                  : srcWidth / 21,
                              color: Styles.yellow,
                            ),
                            onPressed: () {
                              setState(() {
                                isHorizontal = !isHorizontal;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: orientation == Orientation.portrait
                              ? 15 / 1
                              : 50 / 1,
                          child: Container(),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: orientation == Orientation.portrait
                                  ? 30
                                  : 70),
                          child: Styles.buildH2("General Information"),
                        ),
                        AspectRatio(
                          aspectRatio:
                              orientation == Orientation.portrait ? 2.2 : 4,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(
                                left: orientation == Orientation.portrait
                                    ? 30
                                    : 70,
                                top: 10,
                                bottom: 10),
                            children: <Widget>[
                              AspectRatio(
                                  aspectRatio: 0.9,
                                  child: MenuCard(
                                      card: Data.infoCardData,
                                      radius:
                                          orientation == Orientation.portrait
                                              ? srcWidth / 20
                                              : srcWidth / 40,
                                      margin:
                                          orientation == Orientation.portrait
                                              ? srcWidth / 50
                                              : srcWidth / 100)),
                              SizedBox(
                                width: 25,
                              ),
                              AspectRatio(
                                  aspectRatio: 0.9,
                                  child: MenuCard(
                                      card: Data.accessCardData,
                                      radius:
                                          orientation == Orientation.portrait
                                              ? srcWidth / 20
                                              : srcWidth / 40,
                                      margin:
                                          orientation == Orientation.portrait
                                              ? srcWidth / 50
                                              : srcWidth / 100)),
                            ],
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: orientation == Orientation.portrait
                              ? 15 / 1
                              : 50 / 1,
                          child: Container(),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: orientation == Orientation.portrait
                                  ? 30
                                  : 70),
                          child: Styles.buildH2("Federal and State Laws"),
                        ),
                        isHorizontal
                            ? AspectRatio(
                                aspectRatio: orientation == Orientation.portrait
                                    ? 2.2
                                    : 4,
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.only(
                                      left: orientation == Orientation.portrait
                                          ? 30
                                          : 70,
                                      top: 10,
                                      bottom: 10),
                                  children: <Widget>[
                                    AspectRatio(
                                        aspectRatio: 0.9,
                                        child: MenuCard(
                                            card: Data.fedCardData,
                                            radius: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 20
                                                : srcWidth / 40,
                                            margin: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 50
                                                : srcWidth / 100)),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    AspectRatio(
                                        aspectRatio: 0.9,
                                        child: MenuCard(
                                            card: Data.actCardData,
                                            radius: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 20
                                                : srcWidth / 40,
                                            margin: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 50
                                                : srcWidth / 100)),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    AspectRatio(
                                        aspectRatio: 0.9,
                                        child: MenuCard(
                                            card: Data.nswCardData,
                                            radius: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 20
                                                : srcWidth / 40,
                                            margin: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 50
                                                : srcWidth / 100)),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    AspectRatio(
                                        aspectRatio: 0.9,
                                        child: MenuCard(
                                            card: Data.ntCardData,
                                            radius: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 20
                                                : srcWidth / 40,
                                            margin: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 50
                                                : srcWidth / 100)),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    AspectRatio(
                                        aspectRatio: 0.9,
                                        child: MenuCard(
                                            card: Data.qldCardData,
                                            radius: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 20
                                                : srcWidth / 40,
                                            margin: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 50
                                                : srcWidth / 100)),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    AspectRatio(
                                        aspectRatio: 0.9,
                                        child: MenuCard(
                                            card: Data.saCardData,
                                            radius: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 20
                                                : srcWidth / 40,
                                            margin: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 50
                                                : srcWidth / 100)),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    AspectRatio(
                                        aspectRatio: 0.9,
                                        child: MenuCard(
                                            card: Data.tasCardData,
                                            radius: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 20
                                                : srcWidth / 40,
                                            margin: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 50
                                                : srcWidth / 100)),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    AspectRatio(
                                        aspectRatio: 0.9,
                                        child: MenuCard(
                                            card: Data.vicCardData,
                                            radius: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 20
                                                : srcWidth / 40,
                                            margin: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 50
                                                : srcWidth / 100)),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    AspectRatio(
                                        aspectRatio: 0.9,
                                        child: MenuCard(
                                            card: Data.waCardLaw,
                                            radius: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 20
                                                : srcWidth / 40,
                                            margin: orientation ==
                                                    Orientation.portrait
                                                ? srcWidth / 50
                                                : srcWidth / 100)),
                                    SizedBox(
                                      width: 30,
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                child: Column(
                                  children: <Widget>[
                                    AspectRatio(
                                      aspectRatio:
                                          orientation == Orientation.portrait
                                              ? 2.2
                                              : 4,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.only(
                                            left: orientation ==
                                                    Orientation.portrait
                                                ? 30
                                                : 70,
                                            top: 10,
                                            bottom: 10),
                                        children: <Widget>[
                                          AspectRatio(
                                              aspectRatio: 0.9,
                                              child: MenuCard(
                                                  card: Data.fedCardData,
                                                  radius: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 20
                                                      : srcWidth / 40,
                                                  margin: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 50
                                                      : srcWidth / 100)),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          AspectRatio(
                                              aspectRatio: 0.9,
                                              child: MenuCard(
                                                  card: Data.actCardData,
                                                  radius: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 20
                                                      : srcWidth / 40,
                                                  margin: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 50
                                                      : srcWidth / 100)),
                                        ],
                                      ),
                                    ),
                                    AspectRatio(
                                      aspectRatio:
                                          orientation == Orientation.portrait
                                              ? 2.2
                                              : 4,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.only(
                                            left: orientation ==
                                                    Orientation.portrait
                                                ? 30
                                                : 70,
                                            top: 10,
                                            bottom: 10),
                                        children: <Widget>[
                                          AspectRatio(
                                              aspectRatio: 0.9,
                                              child: MenuCard(
                                                  card: Data.nswCardData,
                                                  radius: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 20
                                                      : srcWidth / 40,
                                                  margin: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 50
                                                      : srcWidth / 100)),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          AspectRatio(
                                              aspectRatio: 0.9,
                                              child: MenuCard(
                                                  card: Data.ntCardData,
                                                  radius: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 20
                                                      : srcWidth / 40,
                                                  margin: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 50
                                                      : srcWidth / 100)),
                                        ],
                                      ),
                                    ),
                                    AspectRatio(
                                      aspectRatio:
                                          orientation == Orientation.portrait
                                              ? 2.2
                                              : 4,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.only(
                                            left: orientation ==
                                                    Orientation.portrait
                                                ? 30
                                                : 70,
                                            top: 10,
                                            bottom: 10),
                                        children: <Widget>[
                                          AspectRatio(
                                              aspectRatio: 0.9,
                                              child: MenuCard(
                                                  card: Data.qldCardData,
                                                  radius: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 20
                                                      : srcWidth / 40,
                                                  margin: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 50
                                                      : srcWidth / 100)),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          AspectRatio(
                                              aspectRatio: 0.9,
                                              child: MenuCard(
                                                  card: Data.saCardData,
                                                  radius: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 20
                                                      : srcWidth / 40,
                                                  margin: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 50
                                                      : srcWidth / 100)),
                                        ],
                                      ),
                                    ),
                                    AspectRatio(
                                      aspectRatio:
                                          orientation == Orientation.portrait
                                              ? 2.2
                                              : 4,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.only(
                                            left: orientation ==
                                                    Orientation.portrait
                                                ? 30
                                                : 70,
                                            top: 10,
                                            bottom: 10),
                                        children: <Widget>[
                                          AspectRatio(
                                              aspectRatio: 0.9,
                                              child: MenuCard(
                                                  card: Data.tasCardData,
                                                  radius: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 20
                                                      : srcWidth / 40,
                                                  margin: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 50
                                                      : srcWidth / 100)),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          AspectRatio(
                                              aspectRatio: 0.9,
                                              child: MenuCard(
                                                  card: Data.vicCardData,
                                                  radius: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 20
                                                      : srcWidth / 40,
                                                  margin: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 50
                                                      : srcWidth / 100)),
                                        ],
                                      ),
                                    ),
                                    AspectRatio(
                                      aspectRatio:
                                          orientation == Orientation.portrait
                                              ? 2.2
                                              : 4,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.only(
                                            left: orientation ==
                                                    Orientation.portrait
                                                ? 30
                                                : 70,
                                            top: 10,
                                            bottom: 10),
                                        children: <Widget>[
                                          AspectRatio(
                                              aspectRatio: 0.9,
                                              child: MenuCard(
                                                  card: Data.waCardLaw,
                                                  radius: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 20
                                                      : srcWidth / 40,
                                                  margin: orientation ==
                                                          Orientation.portrait
                                                      ? srcWidth / 50
                                                      : srcWidth / 100)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
