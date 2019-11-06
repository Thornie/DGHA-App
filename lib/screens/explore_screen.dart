import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/bottom_navigation.dart';
import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/components/place_card.dart';
import 'package:dgha_brochure/components/menu_drawer.dart';
import 'package:dgha_brochure/misc/data.dart';
import 'package:dgha_brochure/misc/helper.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/location_data.dart';
import 'package:dgha_brochure/models/page_nav.dart';
import 'package:dgha_brochure/models/place.dart';
import 'package:dgha_brochure/services/open_dynamic_link.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:google_maps_webservice/places.dart";
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ExploreScreen extends StatefulWidget {
  static const String id = "Explore Screen";
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _firestore = Firestore.instance;

  // -------------------------- NOTE: CONTROLLERS
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String userInput = "";
  final TextEditingController _txtController = new TextEditingController();

  // -------------------------- LOCATION
  final places = new GoogleMapsPlaces(apiKey: Data.kGoogleApiKey);

  double latitude;
  double longitude;
  String stateName;
  String type;
  final double radius = 1700;
  bool fetching = true;

  List<LocationData> iniLocationList = new List<LocationData>();
  List<LocationData> locationList = new List<LocationData>();

  // -------------------------- APP DIMENSIONS
  double scrWidth;
  double scrHeight;
  double drawerWidth;

  // NOTE: Init
  @override
  void initState() {
    super.initState();
    Data.pages.add(PageNav.exploreMenuScr);

    OpenDynamicLink.initDynamicLink(context);
    getPlacesFromDatabase();
  }

  // NOTE: disposed
  @override
  void dispose() {
    super.dispose();
    if (Data.pages.last == PageNav.exploreMenuScr) {
      Data.pages.removeLast();
    }
  }

  void calcDimensions(Orientation orientation) {
    this.scrWidth = MediaQuery.of(context).size.width;
    this.scrHeight = MediaQuery.of(context).size.height;

    if (orientation == Orientation.portrait) {
      this.drawerWidth = this.scrWidth * 0.75;
    } else {
      this.drawerWidth = this.scrHeight * 0.75;
    }
  }

  void getPlacesFromDatabase() async {
    final placesFromDatabase =
        await _firestore.collection('location').getDocuments();
    List<LocationData> locations = new List<LocationData>();

    for (var place in placesFromDatabase.documents) {
      LocationData locationData = new LocationData(
          name: place.data['name'],
          address: place.data['address'],
          overallRating: place.data['avgOverallRating'].toDouble(),
          amenitiesRating: place.data['avgAmenitiesRating'].toDouble(),
          customerServiceRating: place.data['avgCustServRating'].toDouble(),
          placeId: place.data['placeId']);

      locations.add(locationData);
    }

    //Sometimes failed to set state when page was disposed to quick
    try {
      setState(() {
        this.iniLocationList = locations;
        this.locationList = locations;
      });
    } catch (e) {
      print(e);
    }
  }

  void getLocations(String input) async {
    List<PlaceByQuery> places = new List<PlaceByQuery>();
    List<LocationData> locations = new List<LocationData>();

    http.Response res = await getPlacesByQuery(
        input: input, state: this.stateName, apiKey: Data.kGoogleApiKey);

    if (res.statusCode == 200) {
      ResponseData data = ResponseData.fromJson(json.decode(res.body));
      print(data.results);

      for (var i = 0; i < data.results.length; i++) {
        PlaceByQuery pbq = PlaceByQuery.fromJson(data.results[i]);
        places.add(pbq);
      }

      for (var i = 0; i < places.length; i++) {
        LocationData ld = new LocationData(
            name: places[i].name,
            address: Helper().formatAddress(places[i].address),
            overallRating: 0,
            // overallRating: places[i].rating.toDouble(),
            customerServiceRating: 0,
            amenitiesRating: 0,
            locationRating: 0,
            placeId: places[i].placeId);
        locations.add(ld);
      }
      setState(() {
        this.locationList = locations;
      });
    }
  }

  Future<http.Response> getPlacesByQuery(
      {String input, String state, String apiKey}) {
    String formattedInput = Helper().formatStringForQuery(input);
    String url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$formattedInput&key=$apiKey';

    return http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.softGrey,
      key: _scaffoldKey,
      drawer: MenuDrawer(
        width: this.drawerWidth,
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            calcDimensions(orientation);
            return Stack(
              children: <Widget>[
                Container(
                  height: this.scrHeight,
                  margin: EdgeInsets.symmetric(horizontal: Styles.spacing),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      SizedBox(height: Styles.heightFromAppBar),

                      // --------------- NOTE: Search Bar
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: buildSearchTextField(
                          prefixIcon: FontAwesomeIcons.search,
                          hintText: "Search place name",
                          onSubmitted: (value) {
                            getLocations(value);
                          },
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      // ----- NOTE: place cards
                      Column(
                        children: placeWidgets(),
                      ),
                    ],
                  ),
                ),

                // ----- NOTE: App Bar
                DghaAppBar(
                  text: "Explore",
                  isMenu: true,
                  childOne: GestureDetector(
                    onTap: () {
                      setState(() {
                        _scaffoldKey.currentState.openDrawer();
                      });
                    },
                    child: DghaIcon(
                      icon: FontAwesomeIcons.bars,
                      backgroundColor: Styles.midnightBlue,
                      iconColor: Styles.yellow,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),

      //-------------------- Bottom navigation --------------------//
      bottomNavigationBar: DGHABotNav(activeTab: ActivePageEnum.ratingsPage),
    );
  }

  List<PlaceCard> placeWidgets() {
    List<PlaceCard> widgets = new List<PlaceCard>();

    if (locationList.length > 0) {
      for (var i = 0; i < this.locationList.length; i++) {
        PlaceCard w = new PlaceCard(
          locationData: this.locationList[i],
        );
        widgets.add(w);
      }
    } else {
      for (var i = 0; i < this.iniLocationList.length; i++) {
        PlaceCard w = new PlaceCard(
          locationData: this.iniLocationList[i],
        );
        widgets.add(w);
      }
    }

    return widgets;
  }

  Widget buildSearchTextField(
      {IconData prefixIcon, String hintText, Function(String) onSubmitted}) {
    return Container(
      decoration: BoxDecoration(
        color: Styles.yellow,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Styles.grey,
            blurRadius: 3,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _txtController,
        onSubmitted: (value) {
          onSubmitted(value);
        },
        style: Styles.pStyle,
        cursorColor: Styles.midnightBlue,
        cursorWidth: 5,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 25, right: 20),
            child: Icon(prefixIcon, color: Styles.midnightBlue),
          ),
          suffix: GestureDetector(
            onTap: () {
              Future.delayed(Duration(milliseconds: 50)).then((_) {
                _txtController.clear();
              });
            },
            child: Padding(
              padding: EdgeInsets.only(right: 25, left: 10),
              child: Icon(
                FontAwesomeIcons.times,
                color: Styles.midnightBlue,
                size: Styles.iconSize,
              ),
            ),
          ),
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }
}
