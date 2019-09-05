import 'package:dgha_brochure/components/icon_background.dart';
import 'package:dgha_brochure/components/menu_tile.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/menu_tile_data.dart';
import 'package:flutter/material.dart';

class MenuExpansionTile extends StatefulWidget {
  final MenuTileData tile;
  MenuExpansionTile({this.tile});

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
            margin: EdgeInsets.only(top: 10),
            child: IconBackground(child: Styles.buildIcon(widget.tile.icon, Styles.yellow)),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: ExpansionTile(
              title: Text(
                widget.tile.title,
                style: Styles.h2TextStyle,
              ),
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