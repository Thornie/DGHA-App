import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/models/screen_args.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/menu_tile_data.dart';

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
        if (tile.link == null) {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(tile.pageToNavigateTo, arguments: ScreenArguments(title: tile.title, texts: tile.texts));
        } else {
          _launchUrl(tile.link);
        }
      },
      child: Semantics(
        label: this.tile.semanticLabel,
        hint: this.tile.semanticHint,
        child: Container(
          constraints: BoxConstraints(minHeight: 50),
          child: Row(
            children: <Widget>[
              Container(
                child: tile.icon != null ? DghaIcon(icon: tile.icon) : Container(),
              ),
              SizedBox(width: this.paddingLeft != null ? this.paddingLeft : 20),
              Expanded(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(this.tile.title, style: Styles.h3LinkStyle, maxLines: 1, overflow: TextOverflow.ellipsis,),
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
