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
import 'package:dgha_brochure/models/page_nav.dart';
import 'package:dgha_brochure/models/place.dart';
import 'package:dgha_brochure/screens/login_screen.dart';
import 'package:dgha_brochure/screens/report_screen.dart';
import 'package:dgha_brochure/screens/user_rating_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dgha_brochure/models/review.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetailsScreen extends StatefulWidget {
  static const String id = "Review Screen";
  final PlaceData placeData;

  PlaceDetailsScreen(this.placeData);

  @override
  _PlaceDetailsScreenState createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  bool isLoading = false;
  List<Review> reviewList = new List<Review>();
  int reviewPageIndex = 0;

  // NOTE: Init
  @override
  void initState() {
    super.initState();
    getReviews();
    Data.pages.add(PageNav.placeDetailsScr);
  }

  void getReviews() async {
    setState(() {
      this.isLoading = true;
    });

    List<Review> list = List<Review>();

    list = await DghaApi.getReviewsFromPlaceIdAndSet(widget.placeData.placeId, reviewPageIndex);

    try {
      setState(() {
        this.isLoading = false;
        this.reviewList = list;
      });
    } catch (e) {
      print(e);
    }
  }

  void reviewBtnHandler() async {
    if (DghaApi.currentClient != null) {
      final result = await Navigator.pushNamed(context, UserRatingScreen.id, arguments: widget.placeData);
      if (result) {
        getReviews();
      }
    } else {
      Navigator.of(context).pushNamed(
        LoginScreen.id_user_rating,
        arguments: widget.placeData,
      );
    }
  }

  void reportBtnHandler() {
    if (DghaApi.currentClient != null) {
      Navigator.pushNamed(context, ReportScreen.id, arguments: widget.placeData);
    } else {
      Navigator.of(context).pushNamed(
        LoginScreen.id_report,
        arguments: widget.placeData,
      );
    }
  }

  void _launchMap(String placeId) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=Google&query_place_id=$placeId';

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
                      widget.placeData.name,
                      style: Styles.h2Style,
                    ),
                  ),

                  // --------- NOTE: Address
                  Container(
                    child: Text(
                      widget.placeData.address,
                      style: Styles.pStyle,
                    ),
                  ),

                  SizedBox(height: Styles.spacing * 0.5),

                  // --------- NOTE: Stars
                  stars(),

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
                            hint: "Double tap to leave a review for ${widget.placeData.name}",
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

                  Builder(
                    builder: (context) {
                      if (this.isLoading) {
                        // ----- NOTE: loading screen
                        return Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Loading...",
                            style: Styles.h1Style,
                          ),
                        );
                      } else {
                        if (this.reviewList.length > 0) {
                          return Container(child: Column(children: buildReviews()));
                        } else {
                          return Column(
                            children: <Widget>[
                              textBtnSection("Write the first review!", this.reviewBtnHandler),
                              SizedBox(
                                height: Styles.spacing,
                              ),
                            ],
                          );
                          // --------- NOTE: Reviews
                        }
                      }
                    },
                  ),

                  // --------- NOTE: More Reviews Btn
                  // --------- TODO: Redesign
                  // reviewPlace.averageRating != 0 ? buildMoreReviewsWidget() : Container(),

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
              semanticLabel: "${widget.placeData.name} Reviews",
              childOne: Semantics(
                button: true,
                label: "Menu",
                hint: "Double tap to go back and view other locations",
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.of(context).popAndPushNamed(ExploreScreen.id);
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
                  _launchMap(widget.placeData.placeId);
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
              rating: widget.placeData.avgOverallRating,
              height: 42,
            ),
          ),
          //----------Customer Service Rating
          RatingWithTitle(
            title: "Customer Service",
            rating: widget.placeData.avgCustomerRating,
            isSmall: true,
          ),
          //----------Amenities Rating
          RatingWithTitle(
            title: "Amenities",
            rating: widget.placeData.avgAmentitiesRating,
            isSmall: true,
          ),
          //----------Location Rating
          RatingWithTitle(
            title: "Location",
            rating: widget.placeData.avgLocationRating,
            isSmall: true,
          ),
        ],
      ),
    );
  }

  List<Widget> buildReviews() {
    List<Widget> reviewWidgets = new List<Widget>();

    for (var review in this.reviewList) {
      Widget widget = ReviewContainer(review: review);
      reviewWidgets.add(widget);
    }

    return reviewWidgets;
  }

  Widget iconBtnSection(IconData icon, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: DghaIcon(
          icon: icon,
          iconColor: Styles.yellow,
          backgroundColor: Styles.midnightBlue,
          size: MediaQuery.of(context).size.width * 0.05,
          padding: 15,
          paddingPadding: 3,
        ),
      ),
    );
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

  // ------- NOTE: More Reviews
  // Widget buildMoreReviewsWidget() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: <Widget>[
  //       iconBtnSection(FontAwesomeIcons.arrowLeft, () {
  //         if (reviewPageIndex - 1 >= 0) {
  //           setState(() {
  //             reviewPageIndex--;
  //             getReviews();
  //           });
  //         }
  //         print(reviewPageIndex);
  //       }),
  //       Text(
  //         (reviewPageIndex + 1).toString(),
  //         style: Styles.h2Style,
  //       ),
  //       iconBtnSection(FontAwesomeIcons.arrowRight, () {
  //         if (reviewPageIndex + 1 < (reviewPlace.count / 5).ceil()) {
  //           setState(() {
  //             reviewPageIndex++;
  //             getReviews();
  //           });
  //         }
  //         print(reviewPageIndex);
  //       }),
  //     ],
  //   );
  // }
}
