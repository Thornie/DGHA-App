import 'package:flutter/material.dart';
import './page_screen/guide_dog_info_screen.dart';
import './page_screen/guide_dog_access_screen.dart';
import './page_screen/law_screen.dart';
import 'package:dgha_brochure/component/navBar.dart';

class MenuScreen extends StatefulWidget {
  static String id = "menu_screen";
  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  final List<Widget> pages = [DGInfoScreen(), DGAccessScreen(), LawScreen()];
  static PageController controller =
      PageController(initialPage: 0, keepPage: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dfsdfsf"),
      ),
      drawer: NavBar(),
      body: PageView(
        children: pages,
        controller: controller,
      ),
    );
  }
}
