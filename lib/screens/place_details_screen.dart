import 'package:dgha/components/appbar.dart';
import 'package:dgha/components/bottom_navigation.dart';
import 'package:dgha/components/dgha_icon.dart';
import 'package:dgha/components/dgha_star_rating.dart';
import 'package:dgha/components/dgha_text_btn.dart';
import 'package:dgha/components/rating_with_title.dart';
import 'package:dgha/components/review_container.dart';
import 'package:dgha/components/view_more_btn.dart';
import 'package:dgha/misc/data.dart';
import 'package:dgha/misc/dgha_api.dart';
import 'package:dgha/misc/styles.dart';
import 'package:dgha/models/page_nav.dart';
import 'package:dgha/models/place.dart';
import 'package:dgha/screens/login_screen.dart';
import 'package:dgha/screens/report_screen.dart';
import 'package:dgha/screens/user_rating_screen.dart';
import 'package:dgha/services/review_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dgha/models/review.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetailsScreen extends StatefulWidget {
  static const String id = "Review Screen";
  final PlaceData placeData;

  PlaceDetailsScreen(this.placeData);

  @override
  _PlaceDetailsScreenState createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  // ------------------------- NOTE: Variables
  bool isLoading = false;
  bool isFirstLoad = true;

  List<ReviewData> reviewList = new List<ReviewData>();
  bool databaseHasMoreReviews = false;
  int setNum = 0;

  // ------------------------- NOTE: Init
  @override
  void initState() {
    super.initState();

    // only run getReviews() if the place has ratings
    if (widget.placeData.numOfAllReviews > 0) {
      getReviews();
    }

    Data.pages.add(PageNav.placeDetailsScr);
  }

  // ------------------------- NOTE: Get Reviews
  void getReviews() async {
    setState(() {
      this.isLoading = true;
    });

    List<ReviewData> _reviewList = await ReviewService.getReviewSetById(widget.placeData.placeId, this.setNum);

    try {
      // check if it is 6 because that means there will be more reviews to come
      if (_reviewList.length == 6) {
        setState(() {
          this.databaseHasMoreReviews = true;
        });
        _reviewList.removeLast();
      } else {
        setState(() {
          this.databaseHasMoreReviews = false;
        });
      }

      setState(() {
        this.isLoading = false;
        this.reviewList.addAll(_reviewList);
        this.setNum = this.setNum + 1; // can't use increment (i++)
        this.isFirstLoad = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void reviewBtnHandler() async {
    if (DghaApi.currentClient != null) {
      print(DghaApi.currentClient.credentials.expiration);
      print(DghaApi.currentClient.credentials.isExpired);
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
      Navigator.of(context).pushNamed(LoginScreen.id_report, arguments: widget.placeData);
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

  String getTypes() {
    String types = "";

    for (int i = 0; i < widget.placeData.types.length; i++) {
      if (Data.allPlaceTypes.contains(widget.placeData.types[i])) {
        //For each word in the string
        String type = widget.placeData.types[i].replaceAll(RegExp('_'), ' ');
        List<String> splitStr = type.split(" ");
        String word = "";

        for (int j = 0; j < splitStr.length; j++) {
          //Captitalize first letter
          word += '${splitStr[j][0].toUpperCase()}${splitStr[j].substring(1)} ';
        }

        types += "${word.trim()}, ";
      }
    }

    //Remove end comma and whitespace
    if (types != "") {
      types = types.trim();
      types = types.substring(0, types.length - 1);
    }

    return types;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (Data.pages.last == PageNav.placeDetailsScr) {
      Data.pages.removeLast();
    }
  }

  @override
  Widget build(BuildContext context) {
    String types = getTypes();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: Styles.spacing),

              // ----------------------------- NOTE: Body
              child: ListView(
                children: <Widget>[
                  SizedBox(height: Styles.heightFromAppBar),

                  // ---------------- NOTE: Place Name
                  Container(child: Text(widget.placeData.name, style: Styles.h2Style)),

                  // ---------------- NOTE: Address
                  Container(child: Text(widget.placeData.address, style: Styles.pStyle)),

                  SizedBox(height: Styles.spacing * 0.5),

                  // ---------------- NOTE: Types
                  Builder(
                    builder: (context) {
                      if (types != "") {
                        return Container(child: Text(types, style: Styles.pStyle));
                      } else {
                        return Container(height: 0);
                      }
                    },
                  ),

                  SizedBox(height: Styles.spacing * 0.5),

                  // -------------------------------- NOTE: Stars
                  buildStar(rating: widget.placeData.avgOverallRating, ratingLabel: 'Overall Rating', isBigStar: true),
                  buildStar(rating: widget.placeData.avgCustomerRating, ratingLabel: 'Customer Service Rating', isBigStar: false),
                  buildStar(rating: widget.placeData.avgAmentitiesRating, ratingLabel: 'Amenities Rating', isBigStar: false),
                  buildStar(rating: widget.placeData.avgLocationRating, ratingLabel: 'Location Rating', isBigStar: false),

                  // ---------------- NOTE: Review Heading Row
                  Semantics(
                    explicitChildNodes: true,
                    child: buildReviewHeader(),
                  ),

                  // ---------------- NOTE: Reviews
                  _buildeReviewSection(),

                  ViewMoreBtn(
                    condition: this.databaseHasMoreReviews,
                    loadingCondition: this.isLoading,
                    onTap: this.getReviews,
                    bottomPadding: Styles.spacing,
                  ),
                  PlaceDetailBtnText(text: "Report Venue", onTap: this.reportBtnHandler),
                  SizedBox(height: Styles.spacing),
                ],
              ),
            ),

            // ------------- NOTE: App Bar
            DghaAppBar(
              text: "Reviews",
              isMenu: true,
              semanticLabel: "${widget.placeData.name} Reviews",
              childOne: Semantics(
                button: true,
                label: "Back",
                hint: "Double tap to go back",
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
              childTwo: Semantics(
                label: "Map",
                button: true,
                hint: "Double tap to open google maps",
                child: GestureDetector(
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: DGHABotNav(activeTab: ActivePageEnum.ratingsPage),
    );
  }

  Row buildReviewHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(child: Text("Reviews", style: Styles.h2Style)),

        // ---------- NOTE: Review Btn
        GestureDetector(
          onTap: () {
            reviewBtnHandler();
          },
          child: Semantics(
            label: "Write Review",
            button: true,
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
    );
  }

  Semantics buildStar({double rating, String ratingLabel, bool isBigStar}) {
    String ratingStr = rating.toStringAsPrecision(2);
    return Semantics(
      label: "$ratingLabel: $ratingStr stars",
      child: Center(
        child: Semantics(
          excludeSemantics: true,
          child: isBigStar ? buildBigStar(rating) : buildSmallStar(rating, ratingLabel),
        ),
      ),
    );
  }

  DghaStarRating buildBigStar(double rating) {
    return DghaStarRating(
      changeRatingOnTap: false,
      rating: rating,
      height: 42,
    );
  }

  RatingWithTitle buildSmallStar(double rating, String ratingLabel) {
    return RatingWithTitle(
      title: ratingLabel,
      rating: rating,
      isSmall: true,
    );
  }

  Widget _buildeReviewSection() {
    return Semantics(
      explicitChildNodes: true,
      child: Builder(
        builder: (context) {
          if (this.reviewList.isNotEmpty) {
            return Column(
              children: this
                  .reviewList
                  .map((review) => ReviewContainer(
                        review: review,
                      ))
                  .toList(),
            );
          } else if (widget.placeData.numOfAllReviews > 0 && this.isFirstLoad) {
            return Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 2,
                  color: Styles.midnightBlue,
                ),
                SizedBox(
                  height: Styles.spacing / 2,
                ),
                Container(
                  child: Text(
                    "Loading . . .",
                    style: Styles.h2Style,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: Styles.spacing / 2,
                ),
              ],
            );
          } else {
            return _buildFirstReviewBtn();
          }
        },
      ),
    );
  }

  Widget _buildFirstReviewBtn() {
    return PlaceDetailBtnText(
      text: "Write the first review!",
      onTap: this.reviewBtnHandler,
      bottomPadding: Styles.spacing,
    );
  }
}

class PlaceDetailBtnText extends StatelessWidget {
  final String text;
  final Function onTap;
  final double bottomPadding;

  PlaceDetailBtnText({@required this.text, @required this.onTap, this.bottomPadding = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: this.bottomPadding),
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
