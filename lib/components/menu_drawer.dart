import 'package:dgha_brochure/components/menu_expansion_tile.dart';
import 'package:dgha_brochure/components/menu_tile.dart';
import 'package:dgha_brochure/misc/data.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Tooltip(
        message: 'Side Menu Bar',
        child: ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          child: Drawer(
            elevation: 20,
            child: ListView(
              children: <Widget>[
                MenuTile(tile: Data.guideDogInfoTileData),
                MenuTile(tile: Data.guideDogAccessTileData),
                MenuExpansionTile(tile: Data.fedTileData),
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
