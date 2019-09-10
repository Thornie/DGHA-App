import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/dgha_icon.dart';
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
  double scrHeight;

  @override
  void initState() {
    super.initState();
    setLang(0);
  }

  void calcDimensions(Orientation orientation) {
    this.scrHeight = MediaQuery.of(context).size.height;
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
          return Stack(
            children: <Widget>[
              Container(
                height: this.scrHeight,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Styles.spacing),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Text("\n" + infoText + "\n", style: Styles.pStyle),
                      ),
                    ),
                  ],
                ),
              ),
              DghaAppBar(
                childOne: Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: DghaIcon(
                      icon: Icons.arrow_back_ios,
                    ),
                  ),
                ),
                childTwo: Container(
                  child: GestureDetector(
                    onTap: () {},
                    child: PopupMenuButton(
                      onSelected: (choice) {
                        int newLangIndex = widget.texts.indexWhere((lang) => lang.languageName == choice);
                        setLang(newLangIndex);
                      },
                      child: DghaIcon(icon: Icons.translate),
                      itemBuilder: (BuildContext ctxt) {
                        return widget.texts.map((Language lang) {
                          return PopupMenuItem(
                            value: lang.languageName,
                            child: Semantics(
                              hint: "Double tap to selected ${lang.languageName} translation.",
                              child: Text(lang.languageName, style: Styles.h3LinkStyle),
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
                text: widget.appBarTitle,
                isMenu: false,
              )
            ],
          );
        },
      )),
    );
  }
}
