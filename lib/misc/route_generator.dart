import 'package:dgha_brochure/models/review_scr_args.dart';
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
    switch (settings.name) {
      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case InfoScreen.id:
        InfoScrArgs infoScrArgs;

        try {
          infoScrArgs = settings.arguments;
        } catch (e) {}
        return MaterialPageRoute(
            builder: (_) => InfoScreen(
                  appBarTitle: infoScrArgs.title,
                  texts: infoScrArgs.texts,
                ));
      case MenuScreen.id:
        return MaterialPageRoute(builder: (_) => MenuScreen());
      case RatingMenuScreen.id:
        return MaterialPageRoute(builder: (_) => RatingMenuScreen());
      case ReviewScreen.id:
        return MaterialPageRoute(builder: (_) => ReviewScreen(settings.arguments));
      case RatingScreen.id:
        ReviewScrArgs reviewScrArgs;
        try {
          reviewScrArgs = settings.arguments;
        } catch (e) {}

        return MaterialPageRoute(
            builder: (_) => RatingScreen(
                  placeId: reviewScrArgs.placeId,
                  placeName: reviewScrArgs.placeName,
                ));
      default:
        return MaterialPageRoute(builder: (_) => MenuScreen());
    }
  }
}
