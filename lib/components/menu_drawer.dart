import 'package:dgha_brochure/components/menu_expansion_tile.dart';
import 'package:dgha_brochure/components/menu_tile.dart';
import 'package:dgha_brochure/misc/data.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  final double width;

  MenuDrawer({this.width});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(Styles.normalRadius), bottomRight: Radius.circular(Styles.normalRadius)),
        child: Container(
          width: this.width,
          constraints: BoxConstraints(
            minWidth: 300,
            maxWidth: 500,
          ),
          child: Drawer(
            elevation: 20,
            semanticLabel: "Side bar menu",
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: Styles.appBarHorizontalPadding),
              children: <Widget>[
                SizedBox(
                  height: Styles.iconSize / 3,
                ),
                MenuTile(tile: Data.guideDogInfoTileData),
                MenuTile(tile: Data.guideDogAccessTileData),
                MenuExpansionTile(tile: Data.lawsTilesListData),
                MenuTile(tile: Data.signUpTileData),
                MenuTile(tile: Data.donateTileData),
                MenuTile(tile: Data.login),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
