import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/bottom_navigation.dart';
import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/components/place_card.dart';
import 'package:dgha_brochure/components/menu_drawer.dart';
import 'package:dgha_brochure/misc/data.dart';
import 'package:dgha_brochure/misc/helper.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/page_nav.dart';
import 'package:dgha_brochure/models/place.dart';
import 'package:dgha_brochure/models/response.dart';
import 'package:dgha_brochure/screens/search_screen.dart';
import 'package:dgha_brochure/services/open_dynamic_link.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class ExploreScreen extends StatefulWidget {
  static const String id = "Explore Screen";
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // ------------------------- NOTE: Variables
  List<PlaceData> placeList = new List<PlaceData>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;

  // ---------- NOTE: Dimensions
  double scrWidth;
  double scrHeight;
  double drawerWidth;

  // NOTE: Init
  @override
  void initState() {
    super.initState();
    Data.pages.add(PageNav.exploreMenuScr);

    OpenDynamicLink.initDynamicLink(context);
    getRecommendedPlaces();
  }

  // NOTE: only works with physical device
  Future<String> getState() async {
    Position pos = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
    List<Placemark> placemarks = await Geolocator().placemarkFromCoordinates(pos.latitude, pos.longitude);
    String state = placemarks[0].administrativeArea;
    return state;
  }

  void getRecommendedPlaces() async {
    setState(() {
      this.isLoading = true;
    });

    // NOTE: only use this when using physical device
    // String state = await getState();
    String state = "Victoria";

    String url = "https://dgha-api-testing.azurewebsites.net/location/all";
    http.Response res = await http.get(url, headers: {"Accept": "application/json"});
    List<PlaceData> localPlaces = new List<PlaceData>();

    if (res.statusCode == 200) {
      List<dynamic> dataList = json.decode(res.body);

      for (var data in dataList) {
        ApiPlaceResult apiResult = ApiPlaceResult.fromJson(data);
        PlaceData place = apiResult.value;

        // there's a place in the database right now thats in the US lol
        if (place.address != "3220 Ingersoll Ave, Des Moines, IA 50312, USA") {
          place.address = Helper().formatAddress(place.address);

          localPlaces.add(place);
        }
      }
    }

    try {
      setState(() {
        this.placeList = localPlaces;
        this.isLoading = false;
      });
    } catch (e) {
      print(e);
    }
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
                            // ----- NOTE: place cards
                            return Column(
                              children: placeWidgets(),
                            );
                          }
                        },
                      )
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
                  childTwo: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SearchScreen.id);
                    },
                    child: DghaIcon(
                      icon: FontAwesomeIcons.search,
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

    if (this.placeList.length > 0) {
      for (var i = 0; i < this.placeList.length; i++) {
        PlaceCard w = new PlaceCard(
          placeData: this.placeList[i],
        );
        widgets.add(w);
      }
    }

    return widgets;
  }
}
