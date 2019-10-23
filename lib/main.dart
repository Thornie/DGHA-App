import 'package:dgha_brochure/misc/route_generator.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(DGHA());

class DGHA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Styles.midnightBlue),
      initialRoute: LoginScreen.id_start,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
