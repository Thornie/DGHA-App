import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/components/rating_with_title.dart';
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
            height: Styles.spacing,
          ),
          Container(
            child: Column(
              children: <Widget>[
                // ------ NOTE: Rate: ⭐⭐⭐⭐⭐
                RatingWithTitle(
                  title: "Rated: ",
                  rating: this.review.overallRating.toDouble(),
                  isSmall: true,
                  spaceBetween: false,
                ),
                Container(
                  width: double.infinity,
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
