import 'package:dgha_brochure/models/languages.dart';
import 'package:flutter/widgets.dart';

class MenuCardData {
  final String title;
  final String pageToNavigateTo;
  final List<Language> texts; 
  final String pageTitle; 

  final Color colour;     // this will be changed to pictures

  MenuCardData({this.title, this.pageToNavigateTo, this.texts, this.colour, this.pageTitle});
}