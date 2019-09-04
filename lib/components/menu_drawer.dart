import 'package:dgha_brochure/misc/data.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/menu_tile_data.dart';
import 'package:dgha_brochure/models/screen_args.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Side Menu Bar',
      child: Drawer(
        child: ListView(children: _buildMenuChildren(context)),
      ),
    );
  }

  void launchURL(String url) async {
    await launch(url);
  }

  List<Widget> _buildMenuChildren(BuildContext context) {
    List<Widget> childrenWidgets = new List<Widget>();

    for (int i = 0; i < Data.menuTiles.length; i++) {
      Widget tile;

      if (Data.menuTiles[i].children.isEmpty) {
        tile = listTile(Data.menuTiles[i], context);
      } else {
        List<Widget> grandChildrenWidgets = new List<Widget>();

        for (int j = 0; j < Data.menuTiles[i].children.length; j++) {
          Widget grandTile = listTile(Data.menuTiles[i].children[j], context);
          grandChildrenWidgets.add(grandTile);
        }

        tile = ExpansionTile(
          key: PageStorageKey(Data.menuTiles[i]),
          title: Text(
            Data.menuTiles[i].title,
            style: Styles.generalTextStyle,
          ),
          children: grandChildrenWidgets,
        );
      }
      childrenWidgets.add(tile);
    }
    return childrenWidgets;
  }

  ListTile listTile(MenuTile root, BuildContext context) {
    return ListTile(
      title: Text(
        root.title,
        style: Styles.generalTextStyle,
      ),
      onTap: () {
        if (root.title == "Donation") {
          launchURL("http://dgha.org.au/dgha/membership/");
        } else if (root.title == "Sign up") {
          launchURL("http://dgha.org.au/dgha/membership/");
        } else {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(root.pageToNavigateTo,
              arguments: ScreenArguments(title: root.title, texts: root.texts));
        }
      },
    );
  }
}
