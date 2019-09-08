import 'package:dgha_brochure/components/icon_bg.dart';
import 'package:dgha_brochure/models/screen_args.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/menu_tile_data.dart';

class MenuTile extends StatelessWidget {
  final MenuTileData tile;
  final double iconSize;

  MenuTile({this.tile, this.iconSize});

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
        padding: EdgeInsets.only(bottom: this.iconSize / 4),
        child: Row(
          children: <Widget>[
            Container(
              child: tile.icon != null
                  ? IconBg(
                      height: this.iconSize,
                      chid: LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            padding: EdgeInsets.only(bottom: 3),
                            child: Icon(
                              this.tile.icon,
                              size: constraints.biggest.width - this.iconSize / 3.5,
                              color: Styles.yellow,
                            ),
                          );
                        },
                      ),
                    )
                  : Container(),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 8,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                    this.tile.title,
                    style: TextStyle(fontFamily: "Manjari", fontWeight: FontWeight.w700, fontSize: 30),
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
