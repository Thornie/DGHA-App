import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/location_reviews.dart';
import 'package:flutter/material.dart';

class SearchRatingScreen extends StatefulWidget {
  @override
  _SearchRatingScreenState createState() => _SearchRatingScreenState();
}

class _SearchRatingScreenState extends State<SearchRatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DghaAppBar(
          isMenu: true,
          text: "Rating",
        ),
        //TODO: insert search bar here
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int _index) {
                return LocationReviews();
              },
            ),
          ),
        ),
      ],
    );
  }
}
