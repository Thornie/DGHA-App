import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';

class DghaIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final double paddingPadding;
  final double padding;

  DghaIcon({
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.size,
    this.paddingPadding,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingPadding != null
          ? this.paddingPadding
          : Styles.iconPaddingPadding),
      child: Container(
        padding:
            EdgeInsets.all(padding != null ? this.padding : Styles.iconPadding),
        decoration: BoxDecoration(
          color: this.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(1000)),
        ),
        child: Icon(
          this.icon,
          size: size != null ? size : Styles.iconSize,
          color: this.iconColor,
        ),
      ),
    );
  }
}
