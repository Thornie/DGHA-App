import 'package:dgha_brochure/components/icon_background.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 13, 0, 13),
              decoration: Styles.customAppBarBoxDecoration,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Tooltip(
                    message: 'Back button',
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: IconBackground(
                        child: IconButton(
                          padding: EdgeInsets.only(right: 2),
                          icon: Styles.buildIcon(FontAwesomeIcons.chevronLeft),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.appBarTitle,
                    style: Styles.customAppBartextStyle,
                  ),
                  Tooltip(
                    message: 'Select language',
                    child: PopupMenuButton(
                      onSelected: (choice) {
                        int newLangIndex = widget.texts
                            .indexWhere((lang) => lang.languageName == choice);
                        setLang(newLangIndex);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: IconBackground(
                          child: Styles.buildIcon(Icons.translate),
                        ),
                      ),
                      // icon: Styles.buildIcon(Icons.translate, Styles.yellow),
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
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                margin: EdgeInsets.only(left: 30, right: 30),
                child: SingleChildScrollView(
                  child: Text(
                    "\n" + infoText + "\n",
                    style: Styles.pTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
