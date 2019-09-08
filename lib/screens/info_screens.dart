import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/icon_bg.dart';
import 'package:dgha_brochure/misc/helper.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/languages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoScreen extends StatefulWidget {
  static const String id = "Info Screen";
  final String appBarTitle;
  final List<Language> texts;

  InfoScreen({this.appBarTitle, this.texts});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String infoText = "";

  // NOTE: App Properties
  double srcWidth;
  double srcHeight;
  double horizontalPadding = 30;

  // NOTE: App Bar Properties
  double appBarHeight;
  double appBarRadius;

  // Pop Menu

  // NOTE: Text

  @override
  void initState() {
    super.initState();
    setLang(0);
  }

  void calcDimensions(Orientation orientation) {
    // NOTE: App
    this.srcWidth = MediaQuery.of(context).size.width;
    this.srcHeight = MediaQuery.of(context).size.height;

    // NOTE: App Bar
    this.appBarHeight = orientation == Orientation.portrait ? srcHeight / 12 : srcWidth / 12;
    // this.appBarTextScale = this.appBarHeight / 70;
    this.appBarRadius = this.appBarHeight / 3.5;

    // NOTE: Popmenu
    // this.popMenuTextScale = this.appBarHeight / 90 < 1.2 ? this.appBarHeight / 90 : 1.2;
    // this.textScale = this.appBarHeight / 90 < 1.2 ? this.appBarHeight / 90 : 1.2;

  }

  void setLang(int index) {
    Helper().loadAsset(context, widget.texts[index].path).then((data) {
      setState(() {
        infoText = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: OrientationBuilder(
        builder: (context, orientation) {
          this.calcDimensions(orientation);
          return Column(
            children: <Widget>[
              DghaAppBar(
                text: widget.appBarTitle,
                appBarHeight: this.appBarHeight,
                srcWidth: this.srcWidth,
                horizontalPadding: this.horizontalPadding,
                borderRadius: this.appBarRadius,
                leftChild: IconBg(
                  height: this.appBarHeight,
                  chid: LayoutBuilder(
                    builder: (context, constraints) {
                      return IconButton(
                        padding: EdgeInsets.only(bottom: 3, right: 3),
                        icon: Icon(
                          FontAwesomeIcons.chevronLeft,
                          size: constraints.biggest.width - this.appBarHeight / 3.5,
                          color: Styles.yellow,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
                rightChid: IconBg(
                  height: this.appBarHeight,
                  chid: LayoutBuilder(
                    builder: (context, constraints) {
                      return PopupMenuButton(
                        onSelected: (choice) {
                          int newLangIndex = widget.texts.indexWhere((lang) => lang.languageName == choice);
                          setLang(newLangIndex);
                        },
                        child: Container(
                          // padding: EdgeInsets.only(bottom: 3),
                          child: Icon(
                            Icons.translate,
                            size: constraints.biggest.width - this.appBarHeight / 3.5,
                            color: Styles.yellow,
                          ),
                        ),
                        itemBuilder: (BuildContext ctxt) {
                          return widget.texts.map((Language lang) {
                            return PopupMenuItem(
                              value: lang.languageName,
                              height: this.appBarHeight * 0.8,
                              child: Text(
                                lang.languageName,
                                style: TextStyle(fontFamily: "Manjari", fontWeight: FontWeight.w700, fontSize: 35),
                              ),
                            );
                          }).toList();
                        },
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: this.horizontalPadding),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Text(
                      "\n" + infoText + "\n",
                      style: TextStyle(fontFamily: "Manjari", fontWeight: FontWeight.w700, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}
