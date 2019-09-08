import 'package:dgha_brochure/models/languages.dart';

class MenuCardData {
  final String shortTitle; 
  final String pageToNavigateTo;
  final List<Language> texts; 
  final String pageTitle; 
  final String imagePath;   
  final String semanticLabel;
  final String semanticHint; 

  MenuCardData({this.shortTitle, this.pageToNavigateTo, this.texts, this.imagePath, this.pageTitle, this.semanticLabel, this.semanticHint});
}