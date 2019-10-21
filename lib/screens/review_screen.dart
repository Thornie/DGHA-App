import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/bottom_navigation.dart';
import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/components/dgha_star_rating.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/location_data.dart';
import 'package:dgha_brochure/models/location_rating_data.dart';
import 'package:dgha_brochure/screens/rating_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReviewScreen extends StatelessWidget {
  static const String id = "Review Screen";
  final LocationData locationData;

  ReviewScreen(this.locationData);

  @override
  Widget build(BuildContext context) {
    List<LocationRatingData> locationRatingData =
        new List<LocationRatingData>();
    for (var i = 0; i < 5; i++) {
      locationRatingData.add(new LocationRatingData(
          rating: 3,
          comment:
              "ssdseu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."));
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
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
            //----------New Review Button
            GestureDetector(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: DghaIcon(
                      backgroundColor: Styles.midnightBlue,
                      icon: FontAwesomeIcons.pen,
                      iconColor: Styles.yellow,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, RatingScreen.id,
                    arguments: locationData.placeID);
              },
            ),
            //----------Reviews
            Container(
              height: (locationRatingData.length * 160).toDouble(),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: locationRatingData.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: LocationRatingBar(
                          title: "Overall Review",
                          rating: locationRatingData[index].rating,
                          isSmall: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Container(
                          height: 110,
                          width: double.maxFinite,
                          decoration: BoxDecoration(border: Border.all()),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SelectableText(
                              locationRatingData[index].comment,
                              style: Styles.pStyle,
                              scrollPhysics: NeverScrollableScrollPhysics(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DGHABotNav(activeTab: ActivePageEnum.ratingsPage),
    );
  }
}

//The widget to display the average ratings on the page
class LocationRatingBar extends StatelessWidget {
  final String title;
  final double rating;
  final bool isSmall;

  LocationRatingBar({this.title, this.rating, this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSmall ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        //----------Title
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: isSmall
                ? Styles.h3Style.copyWith(fontSize: 18)
                : Styles.h3Style,
          ),
        ),
        DghaStarRating(
          changeRatingOnTap: false,
          rating: rating,
          height: isSmall
              ? MediaQuery.of(context).size.width / 13
              : MediaQuery.of(context).size.width / 10,
        ),
      ],
    );
  }
}
