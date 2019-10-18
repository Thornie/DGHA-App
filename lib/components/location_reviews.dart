import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class LocationReviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(7),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(Styles.normalRadius)),
          boxShadow: [
            BoxShadow(
              color: Styles.grey,
              blurRadius: 6,
              offset: Offset(1, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Location Name',
                  style: Styles.h3Style,
                  overflow: TextOverflow.ellipsis,
                ),
                SmoothStarRating(
                  size: 25.0,
                  rating: 0,
                  color: Colors.orange,
                  borderColor: Styles.midnightBlue,
                ),
              ],
            ),
            Text(
              'Address',
              style: Styles.pStyle,
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
      onTap: () {
        print("S");
      },
    );
  }
}
