import 'package:dgha_brochure/components/icon_background.dart';
import 'package:dgha_brochure/components/menu_tile.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/menu_tile_data.dart';
import 'package:flutter/material.dart';

class MenuExpansionTile extends StatefulWidget {
  final MenuTileData tile;
  final double iconSize; 
  final double bgSize; 
  
  MenuExpansionTile({this.tile, this.iconSize, this.bgSize});

  @override
  _MenuExpansionTileState createState() => _MenuExpansionTileState();
}

class _MenuExpansionTileState extends State<MenuExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: widget.bgSize,
              height: widget.bgSize,
              decoration: BoxDecoration(
                color: Styles.midnightBlue,
                borderRadius: BorderRadius.all(Radius.circular(50))
              ),
              child: Icon(widget.tile.icon, size: widget.iconSize, color: Styles.yellow,)
            ),
          SizedBox(width: 5,),
          Expanded(
            child: ExpansionTile(
              title: Styles.buildH3("Laws"),
              children: _buildChildren(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> children = new List<Widget>();
    for(int i = 0; i < widget.tile.children.length; i++) {
      Widget w = MenuTile(tile: widget.tile.children[i],); 
      children.add(w);
    }
    return children; 
  }
}