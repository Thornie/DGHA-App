import 'package:dgha_brochure/misc/helper.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/languages.dart';
import 'package:flutter/material.dart';

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
              padding: Styles.customAppBarPadding,
              decoration: Styles.customAppBarBoxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Tooltip(
                    message: 'Back button',
                    child: IconButton(
                      icon: Styles.buildIcon(Icons.arrow_back_ios, Styles.yellow),
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
                      icon: Styles.buildIcon(Icons.translate, Styles.yellow),
                      itemBuilder: (BuildContext ctxt) {
                        return widget.texts.map((Language lang) {
                          return PopupMenuItem(
                            value: lang.languageName,
                            child: Text(
                              lang.languageName,
                              style: Styles.pTextStyle,
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
