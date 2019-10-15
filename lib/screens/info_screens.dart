import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/bottom_navigation.dart';
import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/components/menu_drawer.dart';
import 'package:dgha_brochure/components/selectable_contrainer.dart';
import 'package:dgha_brochure/misc/helper.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/languages.dart';
import 'package:dgha_brochure/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  static const String id = "Info Screen";
  final String appBarTitle;
  final List<Language> texts;

  InfoScreen({this.appBarTitle, this.texts});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  // used for closing or opening drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String infoText = "";
  String languageName = "";
  double scrHeight;
  double scrWidth;
  double textScale;
  double popUpHeight;
  final double popUpTextHeight = 50;
  final double popUpMaxHeight = 90;

  // drawer properties
  double drawerWidth;

  List<String> spans = new List<String>();

  @override
  void initState() {
    super.initState();
    loadText(0);
    // setLang(0);
  }

  void calcDimensions(Orientation orientation) {
    this.scrWidth = MediaQuery.of(context).size.width;
    this.scrHeight = MediaQuery.of(context).size.height;
    this.textScale = MediaQuery.of(context).textScaleFactor;

    if (this.textScale < 1.5 || this.textScale == 1.5) {
      this.popUpHeight = this.popUpTextHeight;
    } else if (this.textScale > 1.5 && this.textScale < 2) {
      this.popUpHeight = this.popUpTextHeight * this.textScale * 0.8;
    } else if (this.textScale > 2 || this.textScale == 2) {
      this.popUpHeight = this.popUpTextHeight * this.textScale * 0.7;
    }

    this.popUpHeight = this.popUpHeight > this.popUpMaxHeight
        ? this.popUpMaxHeight
        : this.popUpHeight;
    this.drawerWidth = orientation == Orientation.portrait
        ? this.scrWidth * 0.75
        : this.scrHeight * 0.75;
  }

  void loadText(int index) {
    Helper().loadMd(context, widget.texts[index].path).then((data) {
      setState(() {
        this.spans = data;
        languageName = widget.texts[index].languageName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MenuDrawer(
        width: this.drawerWidth,
      ),
      body: SafeArea(child: OrientationBuilder(
        builder: (context, orientation) {
          calcDimensions(orientation);
          return Stack(
            children: <Widget>[
              Container(
                height: this.scrHeight,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),

                    // ------------ TEXT
                    // -------- LANGUAGE INDICATOR
                    Container(
                      child: languageName == "English"
                          ? Container()
                          : Container(
                              padding: EdgeInsets.only(
                                  top: Styles.spacing, left: 20),
                              child: SelectableText(
                                "$languageName",
                                style: Styles.highlightText,
                              ),
                            ),
                    ),
                    // ------- ACTUAL TEXT
                    SelectableContainer(
                      text: spans,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),

              // --------------- APP BAR
              DghaAppBar(
                text: widget.appBarTitle,
                isMenu: false,
                semanticLabel: widget.appBarTitle,
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
                childTwo: Container(
                  child: PopupMenuButton(
                    onSelected: (choice) {
                      int newLangIndex = widget.texts
                          .indexWhere((lang) => lang.languageName == choice);
                      loadText(newLangIndex);
                    },
                    child: Semantics(
                      button: true,
                      label: "Translate",
                      hint: "Double tap to open translate drop down menu",
                      child: DghaIcon(
                        icon: Icons.translate,
                        backgroundColor: Styles.midnightBlue,
                        iconColor: Styles.yellow,
                      ),
                    ),
                    itemBuilder: (BuildContext ctxt) {
                      return widget.texts.map((Language lang) {
                        return PopupMenuItem(
                          height: this.popUpHeight,
                          value: lang.languageName,
                          child: Semantics(
                            hint:
                                "Double tap to select ${lang.languageName} translation.",
                            child: Container(
                              child: Text(
                                lang.languageName,
                                style: Styles.h3LinkStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ],
          );
        },
      )),
      bottomNavigationBar: DGHABotNav(
        activeTabColor: Styles.yellow,
        activeTab: 1,
      ),
    );
  }
}
