import 'package:dgha_brochure/components/menu_expansion_tile.dart';
import 'package:dgha_brochure/components/menu_tile.dart';
import 'package:dgha_brochure/misc/data.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  final double borderRadius;
  final double width;
  final double marginLeft;
  final double iconSize;

  MenuDrawer({this.width, this.borderRadius, this.marginLeft, this.iconSize});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        child: Container(
          width: this.width,
          constraints: BoxConstraints(maxWidth: 500),
          child: Drawer(
            elevation: 20,
            semanticLabel: "Side bar menu",
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: Styles.appBarHorizontalPadding),
              children: <Widget>[
                SizedBox(
                  height: this.iconSize / 3,
                ),
                MenuTile(tile: Data.guideDogInfoTileData),
                MenuTile(tile: Data.guideDogAccessTileData),
                MenuExpansionTile(tile: Data.lawsTilesListData),
                MenuTile(tile: Data.signUpTileData),
                MenuTile(tile: Data.donateTileData),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
