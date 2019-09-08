import 'package:dgha_brochure/components/icon_bg.dart';
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(Styles.iconPadding),
          decoration: BoxDecoration(color: Styles.midnightBlue, borderRadius: BorderRadius.all(Radius.circular(1000))),
          child: Icon(
            widget.tile.icon,
            size: Styles.iconSize,
            color: Styles.yellow,
          ),
        ),
        Expanded(
          child: Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: Styles.iconSize / 1.75, left: 20),
                  child: Text(widget.tile.title, style: Styles.h3LinkStyle,),
                ),
                ExpansionTile(
                  title: Text(''),
                  children: _buildChildren(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> children = new List<Widget>();
    for (int i = 0; i < widget.tile.children.length; i++) {
      Widget w = MenuTile(
        tile: widget.tile.children[i],
      );
      children.add(w);
    }
    return children;
  }
}
