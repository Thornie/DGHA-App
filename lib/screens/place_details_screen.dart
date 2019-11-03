import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/bottom_navigation.dart';
import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/components/dgha_star_rating.dart';
import 'package:dgha_brochure/components/rating_with_title.dart';
import 'package:dgha_brochure/components/review_container.dart';
import 'package:dgha_brochure/misc/data.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/location_data.dart';
import 'package:dgha_brochure/models/page_nav.dart';
import 'package:dgha_brochure/models/review_scr_args.dart';
import 'package:dgha_brochure/screens/explore_screen.dart';
import 'package:dgha_brochure/screens/login_screen.dart';
import 'package:dgha_brochure/screens/user_rating_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dgha_brochure/models/review.dart';

class PlaceDetailsScreen extends StatefulWidget {
  static const String id = "Review Screen";
  final LocationData locationData;

  PlaceDetailsScreen(this.locationData);

  @override
  _PlaceDetailsScreenState createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  // ------------- NOTE: FIRESTORE
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  List<Review> reviews = new List<Review>();

  // NOTE: Init
  @override
  void initState() {
    super.initState();
    getReviews();
    getCurrentUser();
    Data.pages.add(PageNav.placeDetailsScr);
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();

      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        print("huh");
      }
    } catch (e) {
      print(e);
    }
  }

  void getReviews() async {
    List<Review> snapShotReviews = new List<Review>();
    QuerySnapshot snapshot = await _firestore.collection('reviews').where("placeId", isEqualTo: widget.locationData.placeId).getDocuments();

    for (var doc in snapshot.documents) {
      Review r = new Review(
        email: doc.data['email'],
        overallRating: doc.data['overallRating'].toDouble(),
        comment: doc.data['comment'],
      );
      snapShotReviews.add(r);
    }

    try {
      setState(() {
        this.reviews = snapShotReviews;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.symmetric(horizontal: Styles.spacing),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: Styles.heightFromAppBar,
                  ),

                  //---------- NOTE: Place Name
                  Container(
                    child: Text(
                      widget.locationData.name,
                      style: Styles.h2Style,
                    ),
                  ),

                  // --------- NOTE: Address
                  Container(
                    child: Text(
                      widget.locationData.address,
                      style: Styles.pStyle,
                    ),
                  ),

                  // --------- NOTE: Stars
                  SizedBox(height: Styles.spacing * 0.5),
                  Center(
                    child: DghaStarRating(
                      changeRatingOnTap: false,
                      rating: widget.locationData.overallRating,
                      height: 42,
                    ),
                  ),
                  //----------Customer Service Rating
                  RatingWithTitle(
                    title: "Customer Service",
                    rating: widget.locationData.customerServiceRating,
                    isSmall: true,
                  ),
                  //----------Amenities Rating
                  RatingWithTitle(
                    title: "Amenities",
                    rating: widget.locationData.amenitiesRating,
                    isSmall: true,
                  ),
                  //----------Location Rating
                  RatingWithTitle(
                    title: "Location",
                    rating: widget.locationData.locationRating,
                    isSmall: true,
                  ),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Reviews",
                          style: Styles.h2Style,
                        ),

                        // ---------- NOTE: Review Btn
                        GestureDetector(
                          onTap: () async {
                            if (this.loggedInUser != null) {
                              print(widget.locationData.placeId);
                              String placeId = widget.locationData.placeId;
                              final result = await Navigator.pushNamed(context, UserRatingScreen.id,
                                  arguments: ReviewScrArgs(
                                    placeId: placeId,
                                    placeName: widget.locationData.name,
                                  ));
                              if (result) {
                                setState(() {
                                  getReviews();
                                });
                              }
                            } else {
                              Navigator.of(context).pushNamed(
                                LoginScreen.id_user_rating,
                                arguments: widget.locationData,
                              );
                            }
                          },
                          child: Semantics(
                            button: true,
                            label: "Write Review",
                            hint: "Double tap to leave a review for ${widget.locationData.name}",
                            excludeSemantics: true,
                            child: DghaIcon(
                              icon: FontAwesomeIcons.pen,
                              iconColor: Styles.yellow,
                              backgroundColor: Styles.midnightBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //----------Reviews
                  Column(
                    children: buildReviews(),
                  )
                ],
              ),
            ),

            // ---- NOTE: App Bar
            DghaAppBar(
              text: "Reviews",
              isMenu: true,
              semanticLabel: "${widget.locationData.name} Reviews",
              childOne: Semantics(
                button: true,
                label: "Menu",
                hint: "Double tap to go back and view other locations",
                child: Semantics(
                  button: true,
                  label: "Menu",
                  hint: "Double tap to open side bar menu",
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(ExploreScreen.id);
                    },
                    child: DghaIcon(
                      icon: FontAwesomeIcons.arrowLeft,
                      backgroundColor: Styles.midnightBlue,
                      iconColor: Styles.yellow,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DGHABotNav(activeTab: ActivePageEnum.ratingsPage),
    );
  }

  List<Widget> buildReviews() {
    List<Widget> reviewWidgets = new List<Widget>();

    for (var review in this.reviews) {
      Widget widget = ReviewContainer(review: review);
      reviewWidgets.add(widget);
    }

    return reviewWidgets;
  }
}
