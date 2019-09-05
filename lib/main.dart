import 'package:dgha_brochure/misc/route_generator.dart';
import 'package:dgha_brochure/screens/menu_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(DGHA());

class DGHA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MenuScreen.id,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}