import 'package:dgha_brochure/misc/route_generator.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/screens/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:dgha_brochure/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(DGHA());

class DGHA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Styles.midnightBlue),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    loadPage();
  }

  void loadPage() async {
    var result = await loadLoginScr();
    bool hasOpened = result[0] as bool;
    SharedPreferences prefs = result[1] as SharedPreferences;

    if (hasOpened) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, ExploreScreen.id);
      });
    } else {
      await prefs.setBool('hasOpened', true);

      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      });
    }
  }

  Future<List<dynamic>> loadLoginScr() {
    return SharedPreferences.getInstance().then((prefs) {
      bool hasOpened = prefs.getBool('hasOpened') == null ? false : true;
      return [hasOpened, prefs];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
