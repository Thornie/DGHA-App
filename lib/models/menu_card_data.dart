import 'package:dgha_brochure/models/languages.dart';

class MenuCardData {
  final String title;
  final String pageToNavigateTo;
  final List<Language> texts; 
  final String pageTitle; 
  final String imagePath;   

  MenuCardData({this.title, this.pageToNavigateTo, this.texts, this.imagePath, this.pageTitle});
}