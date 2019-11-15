import 'package:dgha/components/dgha_icon.dart';
import 'package:dgha/components/menu_tile.dart';
import 'package:dgha/misc/styles.dart';
import 'package:dgha/models/menu_tile_data.dart';
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
                      DghaIcon(
                        icon: widget.tile.icon,
                        backgroundColor: Styles.midnightBlue,
                        iconColor: Styles.yellow,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            widget.tile.title,
                            style: Styles.txtBtnStyle,
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
                    button: true,
                    hint: this.isCollapsed ? "Double tap to close menu" : widget.tile.semanticHint,

                    // hide the text because its ugly lol.
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

                  // hide the icon because its also ugly
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
