import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/bottom_navigation.dart';
import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/components/dgha_star_rating.dart';
import 'package:dgha_brochure/components/dgha_text_btn.dart';
import 'package:dgha_brochure/components/rating_with_title.dart';
import 'package:dgha_brochure/components/review_container.dart';
import 'package:dgha_brochure/misc/data.dart';
import 'package:dgha_brochure/misc/dgha_api.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/location_data.dart';
import 'package:dgha_brochure/models/page_nav.dart';
import 'package:dgha_brochure/models/review_place.dart';
import 'package:dgha_brochure/models/review_scr_args.dart';
import 'package:dgha_brochure/screens/explore_screen.dart';
import 'package:dgha_brochure/screens/login_screen.dart';
import 'package:dgha_brochure/screens/report_screen.dart';
import 'package:dgha_brochure/screens/user_rating_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dgha_brochure/models/review.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetailsScreen extends StatefulWidget {
  static const String id = "Review Screen";
  final LocationData locationData;

  PlaceDetailsScreen(this.locationData);

  @override
  _PlaceDetailsScreenState createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  ReviewPlace reviewPlace = new ReviewPlace(reviews: List<Review>());

  // NOTE: Init
  @override
  void initState() {
    super.initState();
    getReviews();
    Data.pages.add(PageNav.placeDetailsScr);
  }

  void getReviews() async {
    ReviewPlace list =
        await DghaApi.getReviewsFromPlaceId(widget.locationData.placeId);
    try {
      setState(() {
        this.reviewPlace = list;
      });
    } catch (e) {
      print(e);
    }
  }

  void reviewBtnHandler() async {
    if (DghaApi.currentClient != null) {
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
  }

  void reportBtnHandler() {
    if (DghaApi.currentClient != null) {
      Navigator.pushNamed(context, ReportScreen.id,
          arguments: widget.locationData);
    } else {
      Navigator.of(context).pushNamed(
        LoginScreen.id_report,
        arguments: widget.locationData,
      );
    }
  }

  void _launchMap(String placeId) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=Google&query_place_id=$placeId';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("something wrong!");
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

                  SizedBox(height: Styles.spacing * 0.5),

                  // --------- NOTE: Stars
                  Container(
                    child:
                        reviewPlace.averageRating != 0 ? stars() : Container(),
                  ),

                  // --------- NOTE: Review Section
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
                          onTap: () {
                            reviewBtnHandler();
                          },
                          child: Semantics(
                            button: true,
                            label: "Write Review",
                            hint:
                                "Double tap to leave a review for ${widget.locationData.name}",
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

                  // --------- NOTE: Reviews
                  Container(
                    child: this.reviewPlace.reviews.length > 0
                        ? Column(children: buildReviews())
                        : textBtnSection(
                            "Write the first review!", this.reviewBtnHandler),
                  ),

                  // --------- NOTE: Report
                  textBtnSection("Report Venue", this.reportBtnHandler),

                  SizedBox(height: Styles.spacing),
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

              // NOTE: Map Btn
              childTwo: GestureDetector(
                onTap: () {
                  _launchMap(widget.locationData.placeId);
                },
                child: DghaIcon(
                  icon: FontAwesomeIcons.mapMarkerAlt,
                  iconColor: Styles.yellow,
                  backgroundColor: Styles.midnightBlue,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DGHABotNav(activeTab: ActivePageEnum.ratingsPage),
    );
  }

  Widget stars() {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: DghaStarRating(
              changeRatingOnTap: false,
              rating: reviewPlace.averageRating,
              height: 42,
            ),
          ),
          //----------Customer Service Rating
          RatingWithTitle(
            title: "Customer Service",
            rating: reviewPlace.averageServiceRating,
            isSmall: true,
          ),
          //----------Amenities Rating
          RatingWithTitle(
            title: "Amenities",
            rating: reviewPlace.averageAmenitiesRating,
            isSmall: true,
          ),
          //----------Location Rating
          RatingWithTitle(
            title: "Location",
            rating: reviewPlace.averageLocationRating,
            isSmall: true,
          ),
        ],
      ),
    );
  }

  List<Widget> buildReviews() {
    List<Widget> reviewWidgets = new List<Widget>();

    for (var review in this.reviewPlace.reviews) {
      Widget widget = ReviewContainer(review: review);
      reviewWidgets.add(widget);
    }

    return reviewWidgets;
  }

  Widget textBtnSection(String text, Function onTap) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 2,
            color: Styles.midnightBlue,
          ),
          SizedBox(
            height: Styles.spacing,
          ),
          DghaTextButton(
            minWidth: MediaQuery.of(context).size.width * 0.45,
            text: text,
            textStyle: Styles.yellowTxtBtnStyle,
            colour: Styles.midnightBlue,
            onTap: () {
              onTap();
            },
          ),
        ],
      ),
    );
  }
}
