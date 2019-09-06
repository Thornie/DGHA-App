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

  @override
  void initState() {
    super.initState();
    setLang(0);
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
    double srcWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(child: OrientationBuilder(
        builder: (context, orientation) {
          double iconSize = orientation == Orientation.portrait
              ? srcWidth / 12
              : srcWidth / 21;
          double marginLeft = orientation == Orientation.portrait ? 30 : 70;
          return Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: orientation == Orientation.portrait
                    ? Styles.appBarAspectRatioPort
                    : Styles.appBarAspectRatioLand,
                child: Tooltip(
                  message: "Back Button",
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
                              FontAwesomeIcons.chevronLeft,
                              size: orientation == Orientation.portrait
                                  ? srcWidth / 12
                                  : srcWidth / 21,
                              color: Styles.yellow,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Styles.buildH1(widget.appBarTitle),
                            )),
                        PopupMenuButton(
                          onSelected: (choice) {
                            int newLangIndex = widget.texts.indexWhere(
                                (lang) => lang.languageName == choice);
                            setLang(newLangIndex);
                          },
                          itemBuilder: (BuildContext ctxt) {
                            return widget.texts.map((Language lang) {
                              return PopupMenuItem(
                                value: lang.languageName,
                                child: Text(
                                  lang.languageName,
                                  style: Styles.h2TextStyle,
                                ),
                              );
                            }).toList();
                          },
                          child: Container(
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
                              child: Icon(
                                Icons.translate,
                                size: iconSize,
                                color: Styles.yellow,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  margin: EdgeInsets.only(left: marginLeft, right: marginLeft),
                  child: SingleChildScrollView(
                    child: Text(
                      "\n" + infoText + "\n",
                      style: Styles.pTextStyle,
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
