import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DghaAppBar extends StatelessWidget {
  final Widget childOne;
  final Widget childTwo;
  final String text;
  final bool isMenu;
  final String semanticLabel;

  DghaAppBar({this.childOne, this.childTwo, this.text, this.isMenu, this.semanticLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Styles.normalRadius),
            bottomRight: Radius.circular(Styles.normalRadius),
          ),
          boxShadow: [BoxShadow(color: Styles.grey, blurRadius: 3, offset: Offset(0, 3))]),
      child: Row(
        children: <Widget>[
          this.childOne,
          Expanded(
            child: Semantics(
              label: this.semanticLabel,
              excludeSemantics: true,
              child: Container(
                child: Text(
                  this.text,
                  style: this.isMenu ? Styles.h1Style : Styles.h2Style,
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                ),
              ),
            ),
          ),
          //DGHAIcon used as padding so the title is centered properly
          this.childTwo != null ? this.childTwo : DghaIcon(
            icon: FontAwesomeIcons.bars, 
            backgroundColor: Colors.transparent,
            iconColor: Colors.transparent
          ),
        ],
      ),
    );
  }
}
