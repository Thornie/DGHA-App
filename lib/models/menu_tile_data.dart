import 'package:dgha_brochure/models/languages.dart';

class MenuTile {
  final String title; 
  final String pageToNavigateTo; 
  final List<Language> texts; 
  final List<MenuTile> children; 

  MenuTile({this.title, this.pageToNavigateTo, this.texts, this.children = const <MenuTile>[]}); 
}