//The widget to display the average ratings on the page
import 'package:dgha/components/dgha_star_rating.dart';
import 'package:dgha/misc/styles.dart';
import 'package:flutter/material.dart';

class RatingWithTitle extends StatelessWidget {
  final String title;
  final double rating;
  final bool isSmall;
  final bool spaceBetween;

  RatingWithTitle({this.title, this.rating, this.isSmall = false, this.spaceBetween = true});

  @override
  Widget build(BuildContext context) {
    double scale = MediaQuery.of(context).textScaleFactor;
    return Row(
      mainAxisAlignment: spaceBetween ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
      children: <Widget>[
        //----------Title
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(
            title,
            style: Styles.h4Style,
          ),
        ),
        Semantics(
          label: "Star Rating",
          hint: "$rating out of 5 stars",
          excludeSemantics: true,
          child: DghaStarRating(
            changeRatingOnTap: false,
            rating: rating,
            height: isSmall ? 26 * scale : 30 * scale,
          ),
        ),
      ],
    );
  }
}
