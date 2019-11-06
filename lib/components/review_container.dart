import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/components/rating_with_title.dart';
import 'package:flutter/material.dart';
import 'package:dgha_brochure/models/review.dart';

class ReviewContainer extends StatelessWidget {
  final Review review;
  ReviewContainer({this.review});

  @override
  Widget build(BuildContext context) {
  String timeCut = review.timeAdded;

  if (timeCut.length > 23) {
    timeCut = timeCut.substring(0, 22);
  }

  DateTime time = DateTime.parse(timeCut);

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 2,
            color: Styles.midnightBlue,
          ),
          SizedBox(
            height: Styles.spacing/2,
          ),
          Align(
            alignment: Alignment.centerLeft,
              child: Text(
                "${time.day}/${time.month}/${time.year}", 
                style: Styles.pStyle,
            ),
          ),
          SizedBox(
            height: Styles.spacing/4,
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
