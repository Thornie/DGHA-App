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
      body: Stack(
        children: <Widget>[
          PageView(children: pages),
          SafeArea(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: new BorderRadius.all(Radius.circular(100)),

              ),
              child: IconButton(
              icon: Icon(Icons.translate),
            ),),
                          ],
                        ),
                      ),
          )
          // SafeArea(
          //   child: Container(
          //     padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: <Widget>[
          //         Ink(
          //           decoration: ShapeDecoration(
          //             shape: CircleBorder()
          //           ),
          //           child: Text("sdfsdf"),
          //         )
          //         // Icon(Icons.translate)
                  
                  
          //     ],),
          //   )
          // )
      ]),
    );
  }
}
