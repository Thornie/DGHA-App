import 'package:dgha_brochure/components/bottom_navigation.dart';
import 'package:dgha_brochure/components/input_textfield.dart';
import 'package:dgha_brochure/components/place_card.dart';
import 'package:dgha_brochure/misc/helper.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/location_data.dart';
import 'package:dgha_brochure/models/place.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SearchScreen extends StatefulWidget {
  static const String id = "Search Screen";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<LocationData> places = List<LocationData>();
  bool isLoading = false;

  void _search({String input}) async {
    setState(() {
      this.isLoading = true;
    });
    String formattedInput = Helper().formatStringForQuery(input);

    // TODO: Will change to the other api url
    String url = 'http://dgha-search.azurewebsites.net/search?query=$formattedInput';

    http.Response res = await http.get(url, headers: {"Accept": "application/json"});

    if (res.statusCode == 200) {
      List<dynamic> rawData = json.decode(res.body);
      List<dynamic> dataV1 = rawData[0];
      List<SearchAPIResponse> searchRes = dataV1.map((r) {
        return SearchAPIResponse(placeId: r['placeId'], name: r['name'], address: r['address'], types: r['types']);
      }).toList();
      List<LocationData> locationData = new List<LocationData>();

      for (var i = 0; i < searchRes.length; i++) {
        LocationData ld = new LocationData(
          name: searchRes[i].name,
          address: searchRes[i].address,
          overallRating: 0,
          customerServiceRating: 0,
          amenitiesRating: 0,
          locationRating: 0,
          placeId: searchRes[i].placeId,
        );
        locationData.add(ld);
      }

      setState(() {
        this.places = locationData;
        this.isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Stack(children: <Widget>[
              ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  SizedBox(
                    height: 100,
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
                        // ----- NOTE: place cards
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: Styles.spacing),
                          child: Column(
                            children: placeWidgets(),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
              Container(
                height: 60,
                width: double.infinity,
                color: Color(0xffFAFAFA),
              ),
              Container(
                padding: EdgeInsets.all(Styles.spacing),
                child: UserInputTextField(
                  prefixIcon: FontAwesomeIcons.arrowLeft,
                  hintText: "Search place name",
                  autoFocus: true,
                  prefixOnTap: () {
                    Navigator.pop(context);
                  },
                  onSubmit: (value) {
                    this._search(input: value);
                  },
                  changeFocusColour: false,
                ),
              ),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: DGHABotNav(activeTab: ActivePageEnum.ratingsPage),
    );
  }

  List<PlaceCard> placeWidgets() {
    List<PlaceCard> widgets = new List<PlaceCard>();

    for (var i = 0; i < this.places.length; i++) {
      PlaceCard w = new PlaceCard(
        locationData: this.places[i],
      );
      widgets.add(w);
    }

    return widgets;
  }
}
