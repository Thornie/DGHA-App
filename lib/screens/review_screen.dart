import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/location_data.dart';
import 'package:dgha_brochure/screens/rating_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewScreen extends StatelessWidget {
  static const String id = "Review Screen";
  final LocationData locationData;

  ReviewScreen(this.locationData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DghaAppBar(
              text: "Reviews",
              isMenu: true,
              semanticLabel: "${locationData.name} Reviews",
              childOne: Semantics(
                button: true,
                label: "Menu",
                hint: "Double tap to go back and view other locations",
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: DghaIcon(
                    icon: FontAwesomeIcons.arrowLeft,
                    backgroundColor: Styles.midnightBlue,
                    iconColor: Styles.yellow,
                  ),
                ),
              ),
            ),
            //----------Location Name
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
              child: Text(
                locationData.name,
                style: Styles.h3Style,
              ),
            ),
            //----------Location
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
              child: Text(
                locationData.address,
                style: Styles.pStyle,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            //----------Overall Rating
            LocationRatingBar(
              title: "Overall Rating",
              rating: locationData.overallRating,
            ),
            SizedBox(
              height: 10,
            ),
            //----------Customer Service Rating
            LocationRatingBar(
              title: "Customer Service",
              rating: locationData.customerServiceRating,
            ),
            //----------Amenities Rating
            LocationRatingBar(
              title: "Amenities",
              rating: locationData.amenitiesRating,
            ),
            //----------Location Rating
            LocationRatingBar(
              title: "Location",
              rating: locationData.locationRating,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: DghaIcon(
                backgroundColor: Styles.midnightBlue,
                icon: FontAwesomeIcons.pen,
                iconColor: Styles.yellow,
              ),
              onTap: () {
                Navigator.pushNamed(context, RatingScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

//The widget to display the average ratings on the page
class LocationRatingBar extends StatelessWidget {
  final String title;
  final double rating;

  LocationRatingBar({this.title, this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        //----------Title
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: Styles.h3Style,
          ),
        ),
        Stack(
          children: <Widget>[
            //----------Star Rating
            SmoothStarRating(
              rating: rating,
              borderColor: Styles.midnightBlue,
              color: Styles.yellow,
              size: MediaQuery.of(context).size.width / 10,
            ),
            //----------Star Rating Outline
            SmoothStarRating(
              borderColor: Styles.midnightBlue,
              size: MediaQuery.of(context).size.width / 10,
            )
          ],
        ),
      ],
    );
  }
}
