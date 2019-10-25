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
import 'package:dgha_brochure/models/place.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:geolocator/geolocator.dart';
import "package:google_maps_webservice/places.dart";
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ExploreScreen extends StatefulWidget {
  static const String id = "Rating Menu Screen";
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _firestore = Firestore.instance;

  // -------------------------- NOTE: CONTROLLERS
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _txtFldCont = new TextEditingController();
  String userInput = "";

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
    getPlacesFromDatabase();
    // getInitialLocations();
    // getCurrentUser();
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

  void getInitialLocations() async {
    List<Place> places = new List<Place>();
    List<LocationData> locations = new List<LocationData>();

    Position position = await getCurrentPosition();
    List<Placemark> placemarks = await getStateName(position);
    http.Response res = await getNearByPlaces(
        latitude: position.latitude,
        longitude: position.longitude,
        radius: this.radius,
        type: 'restaurant',
        apiKey: Data.kGoogleApiKey);

    if (res.statusCode == 200) {
      ResponseData data = ResponseData.fromJson(json.decode(res.body));

      for (var i = 0; i < data.results.length; i++) {
        Place p = Place.fromJson(data.results[i]);
        places.add(p);
      }
    }

    for (var i = 0; i < places.length; i++) {
      LocationData l = new LocationData(
          name: places[i].name,
          address: places[i].address,
          overallRating: places[i].rating.toDouble(),
          customerServiceRating: 0,
          amenitiesRating: 0,
          locationRating: 0);

      locations.add(l);
    }

    setState(() {
      this.iniLocationList = locations;
      this.locationList = locations;
      this.stateName = placemarks.first.administrativeArea;
      this.fetching = false;
    });
  }

  void getLocations(String input) async {
    List<PlaceByQuery> places = new List<PlaceByQuery>();
    List<LocationData> locations = new List<LocationData>();

    http.Response res = await getPlacesByQuery(
        input: input, state: this.stateName, apiKey: Data.kGoogleApiKey);

    if (res.statusCode == 200) {
      ResponseData data = ResponseData.fromJson(json.decode(res.body));

      for (var i = 0; i < data.results.length; i++) {
        PlaceByQuery pbq = PlaceByQuery.fromJson(data.results[i]);
        places.add(pbq);
      }

      for (var i = 0; i < places.length; i++) {
        LocationData ld = new LocationData(
            name: places[i].name,
            address: Helper().formatAddress(places[i].address),
            overallRating: places[i].rating.toDouble(),
            customerServiceRating: 0,
            amenitiesRating: 0,
            locationRating: 0);
        locations.add(ld);
      }
      setState(() {
        this.locationList = locations;
      });
    }
  }

  Future<Position> getCurrentPosition() {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
  }

  Future<List<Placemark>> getStateName(Position pos) async {
    return Geolocator().placemarkFromCoordinates(pos.latitude, pos.longitude);
  }

  Future<http.Response> getNearByPlaces(
      {double latitude,
      double longitude,
      double radius,
      String type,
      String apiKey}) {
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&type=$type&key=$apiKey';
    return http.get(url);
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
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
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: <Widget>[
                        SizedBox(
                          height: 80,
                        ),

                        // --------------- NOTE: Search Bar
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              Styles.spacing, 10, Styles.spacing, 0),
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
                          child: Semantics(
                            label: "Search",
                            hint: "Double tap to search for a location",
                            excludeSemantics: true,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                controller: _txtFldCont,

                                // ----- NOTE: onSubmit
                                onSubmitted: (value) {
                                  getLocations(value);
                                },
                                style: Styles.inputStyle,
                                cursorColor: Styles.midnightBlue,
                                cursorWidth: 5,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.search,
                                    color: Styles.midnightBlue,
                                    size: Styles.iconSize,
                                  ),
                                  suffixIcon: Semantics(
                                    button: true,
                                    label: "Clear",
                                    hint: "Double tap to clear the search bar",
                                    excludeSemantics: true,
                                    child: IconButton(
                                      padding: EdgeInsets.all(20),
                                      onPressed: () {
                                        Future.delayed(
                                                Duration(milliseconds: 50))
                                            .then((_) {
                                          _txtFldCont.clear();
                                        });
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.times,
                                        color: Styles.midnightBlue,
                                        size: Styles.iconSize,
                                      ),
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(30, 10, 30, 10),
                                  hintText: "Search place names or address",
                                  hintStyle: TextStyle(
                                      color: Styles.transMidnightBlue),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              Styles.spacing, 20, Styles.spacing, 30),
                          child: Column(
                            children: locationWidgets(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DghaAppBar(
                    text: "Explore",
                    isMenu: true,
                    semanticLabel: "Explore",
                    childOne: Semantics(
                      button: true,
                      label: "Menu",
                      hint: "Double tap to open side bar menu",
                      child: GestureDetector(
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
                  ),
                ],
              );
            },
          ),
        ),

        //-------------------- Bottom navigation --------------------//
        bottomNavigationBar: DGHABotNav(activeTab: ActivePageEnum.ratingsPage),
      ),
    );
  }

  List<PlaceCard> locationWidgets() {
    List<PlaceCard> widgets = new List<PlaceCard>();

    for (var i = 0; i < this.locationList.length; i++) {
      PlaceCard w = new PlaceCard(
        locationData: this.locationList[i],
      );
      widgets.add(w);
    }

    return widgets;
  }
}
