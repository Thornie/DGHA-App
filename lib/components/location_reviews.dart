import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/location_data.dart';
import 'package:dgha_brochure/screens/review_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class LocationReviews extends StatelessWidget {
  final LocationData locationData;

  LocationReviews({@required this.locationData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(7),
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
                Expanded(
                  child: Text(
                    locationData.name,
                    style: Styles.h3Style,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Stack(
                  children: <Widget>[
                    SmoothStarRating(
                      size: MediaQuery.of(context).size.width / 15,
                      rating: locationData.overallRating,
                      color: Styles.yellow,
                      borderColor: Styles.midnightBlue,
                    ),
                    IgnorePointer(
                      child: SmoothStarRating(
                        allowHalfRating: false,
                        starCount: 5,
                        size: MediaQuery.of(context).size.width / 15,
                        color: Styles.midnightBlue,
                        borderColor: Styles.midnightBlue,
                        spacing: 0.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              locationData.address,
              style: Styles.pStyle,
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, ReviewScreen.id, arguments: locationData);
      },
    );
  }
}
