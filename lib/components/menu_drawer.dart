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
    double srcWidth = MediaQuery.of(context).size.width;
    return OrientationBuilder(builder: (context, orientation) {
      double iconSize = orientation == Orientation.portrait ? srcWidth / 12 : srcWidth / 21;
      double bgSize = orientation == Orientation.portrait ? srcWidth / 7 : srcWidth / 13;
      double drawerWidth = orientation == Orientation.portrait ? srcWidth / 1.2 : srcWidth / 1.8; 
      double marginLeft = orientation == Orientation.portrait ? 0 : 50; 
      
      return SafeArea(
        child: Tooltip(
          message: 'Side Menu Bar',
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: Container(
              width: drawerWidth,
              child: Drawer(
                elevation: 20,
                child: ListView(
                  padding: EdgeInsets.only(left: marginLeft),
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    MenuTile(tile: Data.guideDogInfoTileData, iconSize: iconSize, bgSize: bgSize,),
                    MenuTile(tile: Data.guideDogAccessTileData, iconSize: iconSize, bgSize: bgSize,),
                    MenuExpansionTile(tile: Data.fedTileData, iconSize: iconSize, bgSize: bgSize,),
                    MenuTile(tile: Data.signUpTileData, iconSize: iconSize, bgSize: bgSize,),
                    MenuTile(tile: Data.donateTileData, iconSize: iconSize, bgSize: bgSize,),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}