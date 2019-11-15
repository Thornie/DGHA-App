import 'package:dgha/misc/styles.dart';
import 'package:dgha/components/rating_with_title.dart';
import 'package:flutter/material.dart';
import 'package:dgha/models/review.dart';

class ReviewContainer extends StatelessWidget {
  final ReviewData review;
  ReviewContainer({this.review});

  @override
  Widget build(BuildContext context) {

    DateTime dateAdded = review.formatDateAdded();

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
                "${dateAdded.day}/${dateAdded.month}/${dateAdded.year}", 
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
