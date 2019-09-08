import 'package:dgha_brochure/components/icon_bg.dart';
import 'package:dgha_brochure/components/menu_tile.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/menu_tile_data.dart';
import 'package:flutter/material.dart';

class MenuExpansionTile extends StatefulWidget {
  final MenuTileData tile;
  final double iconSize;

  MenuExpansionTile({this.tile, this.iconSize});

  @override
  _MenuExpansionTileState createState() => _MenuExpansionTileState();
}

class _MenuExpansionTileState extends State<MenuExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.iconSize / 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: IconBg(
              height: widget.iconSize,
              chid: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Icon(
                      widget.tile.icon,
                      size: constraints.biggest.width - widget.iconSize / 3.5,
                      color: Styles.yellow,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    widget.tile.title,
                    style: TextStyle(fontFamily: "Manjari", fontWeight: FontWeight.w700, fontSize: 30),
                  ),
                ),
                ExpansionTile(
                  children: _buildChildren(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> children = new List<Widget>();
    for (int i = 0; i < widget.tile.children.length; i++) {
      Widget w = MenuTile(
        tile: widget.tile.children[i], iconSize: widget.iconSize,
      );
      children.add(w);
    }
    return children;
  }
}
