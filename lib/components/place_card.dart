import 'package:dgha_brochure/components/dgha_star_rating.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/location_data.dart';
import 'package:dgha_brochure/screens/place_details_screen.dart';
import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final LocationData locationData;

  PlaceCard({@required this.locationData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Semantics(
        label: "${locationData.name}",
        hint: "Double tap to view more details",
        excludeSemantics: true,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(15),
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
              Container(
                child: this.locationData.overallRating != 0 ? stars() : noRating(),
              ),
              Text(
                locationData.name,
                style: Styles.h3Style,
              ),
              Text(
                locationData.address,
                style: Styles.pStyle,
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, PlaceDetailsScreen.id, arguments: locationData);
      },
    );
  }

  Widget stars() {
    return Row(
      children: <Widget>[
        IgnorePointer(
          child: DghaStarRating(
            height: 30,
            rating: this.locationData.overallRating,
            starCount: 5,
          ),
        ),
      ],
    );
  }

  // TODO: Show the number of reviews
  Widget noRating() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Styles.yellow,
          borderRadius: BorderRadius.all(
            Radius.circular(Styles.normalRadius),
          )),
      child: Text(
        "No Review",
        style: Styles.boldPStyle,
      ),
    );
  }
}
