import 'package:flutter/material.dart';
import 'screen/menu_screen.dart';

void main() => runApp(DGHA());

class DGHA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MenuScreen.id,
      routes: {
        MenuScreen.id: (context) => MenuScreen()
      },
    );
  }
}