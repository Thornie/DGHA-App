import 'package:dgha/components/dgha_icon.dart';
import 'package:dgha/models/screen_args.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:dgha/misc/styles.dart';
import 'package:dgha/models/menu_tile_data.dart';

class MenuTile extends StatelessWidget {
  final MenuTileData tile;
  final double paddingLeft;

  MenuTile({this.tile, this.paddingLeft});

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (tile.onTap == null) {
          if (tile.link == null) {
            Navigator.pop(context);
            Navigator.of(context).pushNamed(tile.pageToNavigateTo, arguments: InfoScrArgs(title: tile.title, texts: tile.texts));
          } else {
            _launchUrl(tile.link);
          }
        } else {
          tile.onTap();
        }
      },
      child: Semantics(
        button: true,
        label: this.tile.semanticLabel,
        hint: this.tile.semanticHint,
        excludeSemantics: true,
        child: Container(
          constraints: BoxConstraints(minHeight: 50),
          child: Row(
            children: <Widget>[
              Container(
                child: tile.icon != null
                    ? DghaIcon(
                        icon: tile.icon,
                        backgroundColor: Styles.midnightBlue,
                        iconColor: Styles.yellow,
                      )
                    : Container(),
              ),
              SizedBox(width: this.paddingLeft != null ? this.paddingLeft : 20),
              Expanded(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    this.tile.title,
                    style: Styles.txtBtnStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
