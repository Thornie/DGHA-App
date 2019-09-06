import 'package:dgha_brochure/components/icon_background.dart';
import 'package:dgha_brochure/models/screen_args.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/menu_tile_data.dart';

class MenuTile extends StatelessWidget {
  final MenuTileData tile;
  final double iconSize;
  final double bgSize;

  MenuTile({this.tile, this.iconSize, this.bgSize});

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
          Navigator.of(context).pushNamed(tile.pageToNavigateTo,
              arguments: ScreenArguments(title: tile.title, texts: tile.texts));
        } else {
          _launchUrl(tile.link);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 10, bottom: 15),
        child: Row(
          children: <Widget>[
            Container(
              child: tile.icon != null
                  ? Container(
                      width: bgSize,
                      height: bgSize,
                      decoration: BoxDecoration(
                          color: Styles.midnightBlue,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Icon(
                        tile.icon,
                        size: iconSize,
                        color: Styles.yellow,
                      ))
                  : Container(),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 8,
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Styles.buildH3(tile.title)),
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
