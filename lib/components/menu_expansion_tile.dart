import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/components/menu_tile.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/menu_tile_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuExpansionTile extends StatefulWidget {
  final MenuTileData tile;

  MenuExpansionTile({this.tile});

  @override
  _MenuExpansionTileState createState() => _MenuExpansionTileState();
}

class _MenuExpansionTileState extends State<MenuExpansionTile> with TickerProviderStateMixin {
  AnimationController _animationController;
  bool isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            child: Stack(
              children: <Widget>[
                Semantics(
                  excludeSemantics: true,
                  child: Row(
                    children: <Widget>[
                      DghaIcon(icon: widget.tile.icon),
                      SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            widget.tile.title,
                            style: Styles.h3LinkStyle,
                          ),
                        ),
                      ),
                      Icon(
                        this.isCollapsed ? FontAwesomeIcons.solidCaretSquareUp : FontAwesomeIcons.caretSquareDown,
                        color: Styles.midnightBlue,
                        size: 30,
                      )
                    ],
                  ),
                ),
                ExpansionTile(
                  title: Semantics(
                    hint: this.isCollapsed ? widget.tile.semanticHint : "Double tap to close menu",
                    child: Text(
                      'Laws',
                      style: TextStyle(color: Styles.transparent),
                    ),
                  ),
                  onExpansionChanged: (bool) {
                    setState(() {
                      this.isCollapsed = !this.isCollapsed;
                    });
                  },
                  trailing: Text(""),
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
        paddingLeft: 95,
      );
      children.add(w);
    }
    return children;
  }
}
