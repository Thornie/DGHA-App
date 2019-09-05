import 'package:dgha_brochure/models/screen_args.dart';
import 'package:dgha_brochure/screens/info_screens.dart';
import 'package:dgha_brochure/screens/menu_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final ScreenArguments arguments = settings.arguments; 

    switch(settings.name) {
      case InfoScreen.id:
        return MaterialPageRoute(builder: (_) => InfoScreen(appBarTitle: arguments.title, texts: arguments.texts,)); 
      case MenuScreen.id:
        return MaterialPageRoute(builder: (_) => MenuScreen()); 
      default:
        return MaterialPageRoute(builder: (_) => MenuScreen()); 
    }
  }
}