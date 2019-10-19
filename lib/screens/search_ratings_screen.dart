import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/location_reviews.dart';
import 'package:dgha_brochure/models/location_data.dart';
import 'package:flutter/material.dart';

class SearchRatingScreen extends StatefulWidget {
  @override
  _SearchRatingScreenState createState() => _SearchRatingScreenState();
}

class _SearchRatingScreenState extends State<SearchRatingScreen> {
  //List that has all the locations to display
  List<LocationData> locationList;

  @override
  Widget build(BuildContext context) {
    locationList = new List<LocationData>();
    for (var i = 0; i < 5; i++) {
      locationList.add(new LocationData(
        name: "Swinburne University Of Technology",
        address: "John St, Hawthorn VIC 3122",
        overallRating: 4,
        customerServiceRating: 3,
        amenitiesRating: 5,
        locationRating: 3,
        placeID: "SAMPLE",
      ));
    }

    return Column(
      children: <Widget>[
        DghaAppBar(
          isMenu: true,
          text: "Rating",
        ),
        //TODO: insert search bar here
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: locationList.length,
              itemBuilder: (BuildContext context, int index) {
                if (locationList.length < 1) {
                  return Container();
                } else {
                  return LocationReviews(
                    locationData: locationList[index],
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
