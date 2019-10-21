import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/components/rating_breadcrumbs.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/components/rating_screen_section.dart';
import 'package:flutter/material.dart';

class RatingScreen extends StatefulWidget {
  static const String id = "Rating Screen";
  //Use for saving review
  final String placeID;

  RatingScreen(this.placeID);
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
    //-------------------- Rating PageView Screens --------------------//
    //----------Overall Rating
    overallRatingScreen = new RatingScreenSection(
      title: "Overall",
      buttonTitle: "Next",
      hintText:
          "Give an overall rating out of 5 on your experience at this location.",
      //If the page already has a rating, grab that from the object
      rating: overallRatingScreen != null ? overallRatingScreen.rating : 0,
      onPressed: () {
        if (overallRatingScreen.rating != 0) {
          setState(() {
            if (navPosition < 1) navPosition = 1;
          });
          overallRating = overallRatingScreen.rating;
          pageController.jumpToPage(1);
        }
      },
    );
    //----------Customer Service Rating
    customerServiceRatingScreen = new RatingScreenSection(
      title: "Customer Service",
      buttonTitle: "Next",
      hintText:
          "Give a score out of 5 on the customer service provided to you at this location.",
      //If the page already has a rating, grab that from the object
      rating: customerServiceRatingScreen != null
          ? customerServiceRatingScreen.rating
          : 0,
      onPressed: () {
        if (customerServiceRatingScreen.rating != 0) {
          setState(() {
            if (navPosition < 2) navPosition = 2;
          });
          customerServiceRating = customerServiceRatingScreen.rating;
          pageController.jumpToPage(2);
        }
      },
    );
    //----------Amenities Rating
    amenitiesRatingScreen = new RatingScreenSection(
      title: "Amenities",
      buttonTitle: "Next",
      hintText: "Give a score out of 5 on the amenities here at this location.",
      //If the page already has a rating, grab that from the object
      rating: amenitiesRatingScreen != null ? amenitiesRatingScreen.rating : 0,

      onPressed: () {
        if (amenitiesRatingScreen.rating != 0) {
          setState(() {
            if (navPosition < 3) navPosition = 3;
          });
          amenitiesRating = amenitiesRatingScreen.rating;
          pageController.jumpToPage(3);
        }
      },
    );
    //----------Location Rating
    locationRatingScreen = new RatingScreenSection(
      title: "Location",
      buttonTitle: "Next",
      hintText:
          "Give a score out of 5 on the accessibility and ease of access to this location.",
      //If the page already has a rating, grab that from the object
      rating: locationRatingScreen != null ? locationRatingScreen.rating : 0,
      onPressed: () {
        if (locationRatingScreen.rating != 0) {
          setState(() {
            if (navPosition < 4) navPosition = 4;
          });
          locationRating = locationRatingScreen.rating;
          pageController.jumpToPage(4);
        }
      },
    );
    //----------Comment Section
    commentSectionScreen = new CommentSection(
      title: "Comment (Optional)",
      controller: commentController,
      hintText:
          "Add a comment to your review to give more detail on your experience. This is optional.",
      onPressed: () {
        comment = commentController.text;
        //TODO: Save to database here
        print("Overall: $overallRating");
        print("Customer Service: $customerServiceRating");
        print("Amenities: $amenitiesRating");
        print("Location: $locationRating");
        print("Comment: $comment");
        Navigator.of(context).pop();
      },
    );

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          //Close the keyboard when uder taps on screen
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            children: <Widget>[
              //----------App Bar
              DghaAppBar(
                isMenu: true,
                text: "Rating",
                semanticLabel:
                    "Double tap to close the ratings page and cancel your review",
                childOne: GestureDetector(
                  child: DghaIcon(
                    size: 35,
                    padding: 4,
                    backgroundColor: Styles.midnightBlue,
                    iconColor: Styles.yellow,
                    icon: Icons.close,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              //----------Page Navigation
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 30, bottom: 20),
                child: RatingBreadcrumbs(
                  navPosition: navPosition,
                  iconColor: Colors.white,
                  backgroundColor: Styles.grey,
                  highlightedIconColor: Styles.yellow,
                  highlightedBackgroundColor: Styles.midnightBlue,
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
        ),
      ),
    );
  }
}
