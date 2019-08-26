import 'package:flutter/material.dart';
import 'package:dgha_brochure/styles.dart';

class InfoContainer extends StatelessWidget {
  // text
  final String title;
  final String paragraphText;

  // colours
  final Color titleColour;
  final Color paragraphTextColour; 
  final Color containerColour;
  final Color paragraphContainerColour;
  final Color paragraphContainerShadowColour;

  const InfoContainer({
    Key key,
    @required this.title,
    @required this.paragraphText,
    @required this.titleColour, 
    @required this.paragraphTextColour,
    @required this.containerColour,
    @required this.paragraphContainerColour,
    @required this.paragraphContainerShadowColour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.containerColour,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 40, 30, 50),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  this.title,
                  textAlign: TextAlign.center,
                  style: DGHAStyles.titleStyle(this.titleColour),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: DGHAStyles.boxDeco(this.paragraphContainerColour,
                      this.paragraphContainerShadowColour),
                  child: SingleChildScrollView(
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          style: DGHAStyles.paragraphTextStyle(this.paragraphTextColour),
                          children: [TextSpan(text: this.paragraphText)]),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
