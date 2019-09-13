import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectableContainer extends StatelessWidget {
  final List<String> text;

  SelectableContainer({this.text});

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Cound not launch $url";
    }
  }

  List<TextSpan> lines() {
    List<TextSpan> spans = new List<TextSpan>();

    for (int i = 0; i < this.text.length - 1; i++) {
      List<String> words = this.text[i].split(" ");
      String newLine = this.text[i];
      TextStyle textStyle = Styles.pStyle;

      bool isBulletPoint = false;

      // H TAGS
      if (words[0] == "##") {
        newLine = newLine.replaceFirst(new RegExp(r'## '), '');
        textStyle = Styles.h2Style;
      } else if (words[0] == "###") {
        newLine = newLine.replaceFirst(new RegExp(r'### '), '');
        textStyle = Styles.h3Style;
      } else if (words[0] == "####") {
        newLine = newLine.replaceFirst(new RegExp(r'#### '), '');
        textStyle = Styles.h4Style;
      } else if (words[0] == "-" || words[0] == "*") {
        newLine = newLine.replaceFirst(new RegExp(r'- '), '');
        newLine = newLine.replaceFirst(new RegExp(r"\*   "), '');
        isBulletPoint = true;
      }

      if (isBulletPoint) {
        String stringPadding = " \u2022 ";
        TextSpan bullet = TextSpan(text: stringPadding, style: textStyle);
        spans.add(bullet);
      }

      TextSpan ts = TextSpan(
        text: newLine + "\n",
        style: textStyle,
      );
      spans.add(ts);
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    // LINK
    bool isLink = false;
    String line = this.text[this.text.length - 1];
    String frontString = "";
    String endString = "";
    String linkText = "";
    String url = "";

    if (line.contains("https://www.")) {
      int indexOfOpenSquareBracket;
      int indexOfClosedSquareBracket;
      int indexOfOpenBracket;
      int indexOfClosedBracket;

      indexOfOpenSquareBracket = line.indexOf("[");
      indexOfClosedSquareBracket = line.indexOf("]");
      indexOfOpenBracket = line.indexOf("(");
      indexOfClosedBracket = line.indexOf(")");

      frontString = line.substring(0, indexOfOpenSquareBracket);

      if (indexOfClosedBracket < line.length - 1) {
        endString = line.substring(indexOfClosedBracket + 1, line.length - 1);
      }

      linkText = line.substring(indexOfOpenSquareBracket + 1, indexOfClosedSquareBracket);
      url = line.substring(indexOfOpenBracket + 1, indexOfClosedBracket);

      isLink = true;
    }

    return Container(
      padding: EdgeInsets.fromLTRB(Styles.spacing, 20, Styles.spacing, Styles.spacing * 3),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        SelectableText.rich(TextSpan(children: lines())),
        GestureDetector(
          onTap: () {
            isLink ? _launchURL(url) : null;
          },
          child: isLink
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "$frontString: $url",
                    style: Styles.linkStyle,
                  ),
                )
              : Container(),
        ),
      ]),
    );
  }
}
