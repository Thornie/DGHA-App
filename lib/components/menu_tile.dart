import 'package:dgha_brochure/components/icon_bg.dart';
import 'package:dgha_brochure/models/screen_args.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/menu_tile_data.dart';

class MenuTile extends StatelessWidget {
  final MenuTileData tile;

  MenuTile({this.tile});

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
      child: Padding(
        padding: EdgeInsets.only(bottom: Styles.iconSize/2),
        child: Row(
          children: <Widget>[
            Container(
              child: tile.icon != null ? Container(
                padding: EdgeInsets.all(Styles.iconPadding),
                decoration: BoxDecoration(
                  color: Styles.midnightBlue,
                  borderRadius: BorderRadius.all(Radius.circular(1000))
                ),
                child: Icon(this.tile.icon, size: Styles.iconSize, color: Styles.yellow,),
              ) : Container(),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 8,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                    this.tile.title,
                    style: Styles.h3LinkStyle
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
    );
  }
}
