import 'package:dgha_brochure/components/rating_breadcrumbs.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/components/rating_screen_section.dart';
import 'package:flutter/material.dart';

class RatingScreen extends StatefulWidget {
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int navPosition = 0;
  Widget currentPage;
  final controller = PageController(
    initialPage: 0,
    keepPage: false,
  );

  //Initialize ratingPages
  RatingScreenSection overallRatingScreen;
  RatingScreenSection customerServiceRatingScreen;
  RatingScreenSection amenitiesRatingScreen;
  RatingScreenSection locationRatingScreen;
  CommentSection commentSectionScreen;

  //Store Rating Vairables
  double overallRating = 0;
  double customerServiceRating = 0;
  double amenitiesRating = 0;
  double locationRating = 0;
  String comment = "";

  @override
  Widget build(BuildContext context) {
    //-------------------- Rating PageView Screens
    overallRatingScreen = new RatingScreenSection(
      title: "Overall",
      buttonTitle: "Next",
      onPressed: () {
        setState(() {
          navPosition = 1;
        });
        overallRating = overallRatingScreen.rating;
        controller.jumpToPage(1);
      },
    );
    customerServiceRatingScreen = new RatingScreenSection(
      title: "Customer Service",
      buttonTitle: "Next",
      onPressed: () {
        setState(() {
          navPosition = 2;
        });
        customerServiceRating = customerServiceRatingScreen.rating;
        controller.jumpToPage(2);
      },
    );
    amenitiesRatingScreen = new RatingScreenSection(
      title: "Amenities",
      buttonTitle: "Next",
      onPressed: () {
        setState(() {
          navPosition = 3;
        });
        amenitiesRating = amenitiesRatingScreen.rating;
        controller.jumpToPage(3);
      },
    );
    locationRatingScreen = new RatingScreenSection(
      title: "Location",
      buttonTitle: "Next",
      onPressed: () {
        setState(() {
          navPosition = 4;
        });
        locationRating = locationRatingScreen.rating;
        controller.jumpToPage(4);
      },
    );
    commentSectionScreen = new CommentSection(
      title: "Comment (Optional)",
      onPressed: () {
        //TODO: Save to database from here
        print("Overall: $overallRating");
        print("Customer Service: $customerServiceRating");
        print("Amenities: $amenitiesRating");
        print("Location: $locationRating");
        print("Comment: $comment");
      },
    );

    return Column(
      children: <Widget>[
        //----------Close Button
        Align(
          alignment: Alignment.topRight,
          child: MaterialButton(
            child: Icon(
              Icons.close,
              size: 40,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        //----------Page Navigation
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: RatingBreadcrumbs(
            navPosition: navPosition,
            iconColor: Styles.midnightBlue,
            backgroundColor: Colors.grey,
            highlightedColor: Styles.yellow,
          ),
        ),
        //----------Rating Section
        Expanded(
          child: PageView(
            controller: controller,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              overallRatingScreen,
              customerServiceRatingScreen,
              amenitiesRatingScreen,
              locationRatingScreen,
              commentSectionScreen,
            ],
          ),
        ),
      ],
    );
  }
}
