import 'package:dgha_brochure/models/screen_args.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/menu_tile_data.dart';

class MenuTile extends StatelessWidget {
  final MenuTileData tile;

  MenuTile({this.tile});

  _launchUrl(String url) async {
     if(await canLaunch(url)) {
       await launch(url);
     }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(tile.link == null) {
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
              child: tile.icon == null ? Container() : Styles.buildIcon(tile.icon, Styles.yellow),
            ),
            SizedBox(width: 20),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                tile.title,
                style: Styles.pTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}

