import 'package:dgha_brochure/models/languages.dart';
import 'package:flutter/material.dart';

class MenuTileData {
  final String title; 
  final String pageToNavigateTo; 
  final List<Language> texts; 
  final IconData icon; 
  final String link; 
  final List<MenuTileData> children; 
  final String semanticLabel;
  final String semanticHint; 

  MenuTileData({this.title, this.pageToNavigateTo, this.texts, this.icon, this.link, this.children = const <MenuTileData>[], this.semanticHint, this.semanticLabel}); 
}