import 'package:dgha_brochure/models/screen_args.dart';
import 'package:dgha_brochure/screens/info_screens.dart';
import 'package:dgha_brochure/screens/login_screen.dart';
import 'package:dgha_brochure/screens/menu_screen.dart';
import 'package:dgha_brochure/screens/rating_menu_screen.dart';
import 'package:dgha_brochure/screens/rating_screen.dart';
import 'package:dgha_brochure/screens/review_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    ScreenArguments screenArguments;
    try {
      screenArguments = settings.arguments;
    } catch (e) {}

    switch (settings.name) {
      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case InfoScreen.id:
        return MaterialPageRoute(
            builder: (_) => InfoScreen(
                  appBarTitle: screenArguments.title,
                  texts: screenArguments.texts,
                ));
      case MenuScreen.id:
        return MaterialPageRoute(builder: (_) => MenuScreen());
      case RatingMenuScreen.id:
        return MaterialPageRoute(builder: (_) => RatingMenuScreen());
      case ReviewScreen.id:
        return MaterialPageRoute(builder: (_) => ReviewScreen(settings.arguments));
      case RatingScreen.id:
        return MaterialPageRoute(builder: (_) => RatingScreen());
      default:
        return MaterialPageRoute(builder: (_) => MenuScreen());
    }
  }
}
