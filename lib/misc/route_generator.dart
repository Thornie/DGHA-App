import 'package:dgha_brochure/models/review_scr_args.dart';
import 'package:dgha_brochure/models/screen_args.dart';
import 'package:dgha_brochure/screens/info_screen.dart';
import 'package:dgha_brochure/screens/login_screen.dart';
import 'package:dgha_brochure/screens/info_menu_screen.dart';
import 'package:dgha_brochure/screens/explore_screen.dart';
import 'package:dgha_brochure/screens/user_rating_screen.dart';
import 'package:dgha_brochure/screens/register_screen.dart';
import 'package:dgha_brochure/screens/place_details_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case LoginScreen.id_start:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(isStartPage: true));
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
      case InfoMenuScreen.id:
        return MaterialPageRoute(builder: (_) => InfoMenuScreen());
      case ExploreScreen.id:
        return MaterialPageRoute(builder: (_) => ExploreScreen());
      case PlaceDetailsScreen.id:
        return MaterialPageRoute(
            builder: (_) => PlaceDetailsScreen(settings.arguments));
      case UserRatingScreen.id:
        ReviewScrArgs reviewScrArgs;
        try {
          reviewScrArgs = settings.arguments;
        } catch (e) {}

        return MaterialPageRoute(
            builder: (_) => UserRatingScreen(
                  placeId: reviewScrArgs.placeId,
                  placeName: reviewScrArgs.placeName,
                ));
      default:
        return MaterialPageRoute(builder: (_) => InfoMenuScreen());
    }
  }
}
