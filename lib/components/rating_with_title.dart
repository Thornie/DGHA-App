//The widget to display the average ratings on the page
import 'package:dgha_brochure/components/dgha_star_rating.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';

class RatingWithTitle extends StatelessWidget {
  final String title;
  final double rating;
  final bool isSmall;
  final bool spaceBetween;

  RatingWithTitle(
      {this.title,
      this.rating,
      this.isSmall = false,
      this.spaceBetween = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: spaceBetween
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      children: <Widget>[
        //----------Title
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            style: isSmall
                ? Styles.h3Style.copyWith(fontSize: 17)
                : Styles.h3Style,
          ),
        ),
        Semantics(
          label: "Star Rating",
          hint: "$rating out of 5 stars",
          excludeSemantics: true,
          child: DghaStarRating(
            changeRatingOnTap: false,
            rating: rating,
            height: isSmall
                ? MediaQuery.of(context).size.width / 14
                : MediaQuery.of(context).size.width / 11,
          ),
        ),
      ],
    );
  }
}
