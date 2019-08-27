import 'package:flutter/material.dart';
import 'package:dgha_brochure/screen/menu_screen.dart';

class NavBar extends Drawer{

  final TextStyle titleStyle = new TextStyle(
    fontSize: 20,
  );
  final PageController controller = MenuScreenState.controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('About Guide Dogs', 
              style: titleStyle,
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              controller.jumpToPage(0);
            },
          ),
        ],
      ),
    );
  }
}