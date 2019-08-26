import 'package:flutter/material.dart';
import './page_screen/guide_dog_info_screen.dart';
import './page_screen/guide_dog_access_screen.dart';
import './page_screen/law_screen.dart';

class MenuScreen extends StatefulWidget {
  static String id = "menu_screen";
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<Widget> pages = [DGInfoScreen(), DGAccessScreen(), LawScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(children: pages),
    );
  }
}
