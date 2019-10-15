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
  final pageController = PageController(
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

  //Comment Text Controller
  TextEditingController commentController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //-------------------- Rating PageView Screens
    overallRatingScreen = new RatingScreenSection(
      title: "Overall",
      buttonTitle: "Next",
      //If the page already has a rating, grab that from the object
      rating: overallRatingScreen != null ? overallRatingScreen.rating : 0,
      onPressed: () {
        setState(() {
          if (navPosition < 1) navPosition = 1;
        });
        overallRating = overallRatingScreen.rating;
        pageController.jumpToPage(1);
      },
    );
    customerServiceRatingScreen = new RatingScreenSection(
      title: "Customer Service",
      buttonTitle: "Next",
      //If the page already has a rating, grab that from the object
      rating: customerServiceRatingScreen != null
          ? customerServiceRatingScreen.rating
          : 0,
      onPressed: () {
        setState(() {
          if (navPosition < 2) navPosition = 2;
        });
        customerServiceRating = customerServiceRatingScreen.rating;
        pageController.jumpToPage(2);
      },
    );
    amenitiesRatingScreen = new RatingScreenSection(
      title: "Amenities",
      buttonTitle: "Next",
      //If the page already has a rating, grab that from the object
      rating: amenitiesRatingScreen != null ? amenitiesRatingScreen.rating : 0,

      onPressed: () {
        setState(() {
          if (navPosition < 3) navPosition = 3;
        });
        amenitiesRating = amenitiesRatingScreen.rating;
        pageController.jumpToPage(3);
      },
    );
    locationRatingScreen = new RatingScreenSection(
      title: "Location",
      buttonTitle: "Next",
      //If the page already has a rating, grab that from the object
      rating: locationRatingScreen != null ? locationRatingScreen.rating : 0,
      onPressed: () {
        setState(() {
          if (navPosition < 4) navPosition = 4;
        });
        locationRating = locationRatingScreen.rating;
        pageController.jumpToPage(4);
      },
    );
    commentSectionScreen = new CommentSection(
      title: "Comment (Optional)",
      controller: commentController,
      onPressed: () {
        comment = commentController.text;
        //TODO: Save to database here
        print("Overall: $overallRating");
        print("Customer Service: $customerServiceRating");
        print("Amenities: $amenitiesRating");
        print("Location: $locationRating");
        print("Comment: $comment");
      },
    );

    return GestureDetector(
      //Close the keyboard when uder taps on screen
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Column(
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
              controller: pageController,
            ),
          ),
          //----------Rating Section
          Expanded(
            child: PageView(
              controller: pageController,
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
      ),
    );
  }
}
