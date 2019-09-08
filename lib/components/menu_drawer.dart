import 'package:dgha_brochure/components/menu_expansion_tile.dart';
import 'package:dgha_brochure/components/menu_tile.dart';
import 'package:dgha_brochure/misc/data.dart';
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
        child: Tooltip(
          message: 'Side Menu Bar',
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: Container(
              width: this.width,
              constraints: BoxConstraints(maxWidth: 500),
              child: Drawer(
                elevation: 20,
                child: ListView(
                  padding: EdgeInsets.only(left: this.marginLeft),
                  children: <Widget>[
                    SizedBox(
                      height: this.iconSize / 3,
                    ),
                    MenuTile(tile: Data.guideDogInfoTileData, iconSize: iconSize),
                    MenuTile(tile: Data.guideDogAccessTileData, iconSize: iconSize),
                    MenuExpansionTile(tile: Data.fedTileData, iconSize: iconSize),
                    MenuTile(tile: Data.signUpTileData, iconSize: iconSize),
                    MenuTile(tile: Data.donateTileData, iconSize: iconSize),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}