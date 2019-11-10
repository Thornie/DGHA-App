import 'package:dgha_brochure/models/review_scr_args.dart';
import 'package:dgha_brochure/models/screen_args.dart';
import 'package:dgha_brochure/screens/info_screen.dart';
import 'package:dgha_brochure/screens/login_screen.dart';
import 'package:dgha_brochure/screens/info_menu_screen.dart';
import 'package:dgha_brochure/screens/explore_screen.dart';
import 'package:dgha_brochure/screens/report_screen.dart';
import 'package:dgha_brochure/screens/search_screen.dart';
import 'package:dgha_brochure/screens/user_rating_screen.dart';
import 'package:dgha_brochure/screens/register_screen.dart';
import 'package:dgha_brochure/screens/place_details_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case LoginScreen.id_user_rating:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(
                  goToReviewScreen: true,
                  locationData: settings.arguments,
                ));
      case LoginScreen.id_report:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(
                  goToReportScreen: true,
                  locationData: settings.arguments,
                ));
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
        // LocationData blah = settings.arguments as LocationData;
        // print(blah.placeId);
        return MaterialPageRoute(builder: (_) => PlaceDetailsScreen(settings.arguments));
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
      case RegisterScreen.id:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case ReportScreen.id:
        return MaterialPageRoute(builder: (_) => ReportScreen(settings.arguments));
      case SearchScreen.id:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      default:
        return MaterialPageRoute(builder: (_) => InfoMenuScreen());
    }
  }
}
