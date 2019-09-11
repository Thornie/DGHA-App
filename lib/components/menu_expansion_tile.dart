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
    double textScale = MediaQuery.of(context).textScaleFactor;
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
                  Row(
                    children: <Widget>[
                      DghaIcon(icon: widget.tile.icon),
                      Expanded(
                                              child: Container(
                          // padding: EdgeInsets.only(top: 25 / textScale, left: 85),
                          child: Text(
                            widget.tile.title,
                            style: Styles.h3LinkStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Laws',
                      style: TextStyle(color: Styles.transparent),
                    ),
                    onExpansionChanged: (bool) {
                      setState(() {
                        this.isCollapsed = !this.isCollapsed;
                      });
                    },
                    trailing: Container(
                      margin: EdgeInsets.only(top: 5, left: 10),
                      // padding: EdgeInsets.only(left: 1),
                      child: Icon(
                        this.isCollapsed ? FontAwesomeIcons.solidCaretSquareUp : FontAwesomeIcons.caretSquareDown,
                        color: Styles.midnightBlue,
                        size: 35,
                      ),
                    ),
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
