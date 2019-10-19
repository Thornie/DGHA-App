import 'package:dgha_brochure/components/bottom_navigation.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/screens/search_ratings_screen.dart';
import 'package:flutter/material.dart';

class RatingMenuScreen extends StatefulWidget {
  static const String id = "Rating Menu Screen";
  @override
  _RatingMenuScreenState createState() => _RatingMenuScreenState();
}

class _RatingMenuScreenState extends State<RatingMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchRatingScreen(),
      ),
      //-------------------- Bottom navigation --------------------//
      bottomNavigationBar: DGHABotNav(activeTab: ActivePageEnum.ratingsPage),
    );
  }
}
