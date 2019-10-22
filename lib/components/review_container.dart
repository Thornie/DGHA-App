import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/screens/place_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:dgha_brochure/models/review.dart';

class ReviewContainer extends StatelessWidget {
  final Review review;

  ReviewContainer({this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 2,
            color: Styles.midnightBlue,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              children: <Widget>[
                // ------ NOTE: Overall Review
                LocationRatingBar(
                  title: "Rated: ",
                  rating: this.review.overallRating,
                  isSmall: true,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  // decoration: BoxDecoration(border: Border.all()),
                  child: SelectableText(
                    this.review.comment,
                    style: Styles.pStyle,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Styles.spacing,
          ),
        ],
      ),
    );
  }
}
