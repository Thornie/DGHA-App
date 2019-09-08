import 'package:dgha_brochure/components/dgha_icon.dart';
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
    return Semantics(
      label: widget.tile.semanticLabel,
      hint: widget.tile.semanticHint,
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Stack(
                children: <Widget>[
                  DghaIcon(icon: widget.tile.icon),
                  Container(
                    padding: EdgeInsets.only(top: 25, left: 85),
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
      ),
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> children = new List<Widget>();
    for (int i = 0; i < widget.tile.children.length; i++) {
      Widget w = Padding(
        padding: EdgeInsets.only(left: 75),
        child: MenuTile(
        tile: widget.tile.children[i],
      ));
      children.add(w);
    }
    return children;
  }
}
