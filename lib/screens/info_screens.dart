import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/misc/helper.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
  String infoText = "";
  double scrHeight;
  double textScale;
  double popUpHeight;
  final double popUpTextHeight = 50;
  final double popUpMaxHeight = 90;

  @override
  void initState() {
    super.initState();
    setLang(0);
  }

  void calcDimensions() {
    this.textScale = MediaQuery.of(context).textScaleFactor;
    
    if(this.textScale < 1.5 || this.textScale == 1.5) {
      this.popUpHeight = this.popUpTextHeight;
    } else if (this.textScale > 1.5 && this.textScale < 2) {
      this.popUpHeight = this.popUpTextHeight * this.textScale * 0.8; 
    } else if( this.textScale > 2 || this.textScale == 2) {
      this.popUpHeight = this.popUpTextHeight * this.textScale * 0.7; 
    }

    this.popUpHeight = this.popUpHeight > this.popUpMaxHeight ? this.popUpMaxHeight : this.popUpHeight;
  }

  void setLang(int index) {
    Helper().loadTxtFiles(context, widget.texts[index].path).then((data) {
      setState(() {
        infoText = data;
      });
    });
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: OrientationBuilder(
        builder: (context, orientation) {
          calcDimensions();
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

                    // ------------ TEXT
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Styles.spacing),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Html(
                          data: infoText,
                          defaultTextStyle: TextStyle(fontFamily: "Manjari", fontWeight: FontWeight.w700, fontSize: 18 * textScale),
                          onLinkTap: (url) {
                            _launchUrl(url);
                          },
                        ),
                      ),
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
                  label: "Back",
                  hint: "Double tap to go back to home screen",
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
                  child: PopupMenuButton(
                    onSelected: (choice) {
                      int newLangIndex = widget.texts.indexWhere((lang) => lang.languageName == choice);
                      setLang(newLangIndex);
                    },
                    child: Semantics(
                      button: true,
                      label: "Translate",
                      hint: "Double tap to open translate drop down menu",
                      child: DghaIcon(icon: Icons.translate),
                    ),
                    itemBuilder: (BuildContext ctxt) {
                      return widget.texts.map((Language lang) {
                        return PopupMenuItem(
                          height: this.popUpHeight,
                          value: lang.languageName,
                          child: Semantics(
                            hint: "Double tap to select ${lang.languageName} translation.",
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
              )
            ],
          );
        },
      )),
    );
  }
}
