import 'package:dgha_brochure/components/bottom_navigation.dart';
import 'package:dgha_brochure/components/dgha_text_btn.dart';
import 'package:dgha_brochure/components/input_textfield.dart';
import 'package:dgha_brochure/components/place_card.dart';
import 'package:dgha_brochure/misc/helper.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/place.dart';
import 'package:dgha_brochure/models/search_response.dart';
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
  List<PlaceData> placeList = List<PlaceData>();
  String nextPageToken = '';
  String input;
  bool isLoading = false;

  // NOTE: Get Place
  void _search() async {
    setState(() {
      this.isLoading = true;
    });

    String formattedInput = Helper().formatStringForQuery(this.input);

    // TODO: Will change to the other api url
    String url = 'https://dgha-api-testing.azurewebsites.net/location/search?query=$formattedInput&nextpagetoken=$nextPageToken';
    http.Response res = await http.get(url, headers: {"Accept": "application/json"});

    String _nextPageToken;
    List<PlaceData> _placeList = new List<PlaceData>();

    if (res.statusCode == 200) {
      SearchPlaceResponse spr = SearchPlaceResponse.decodePlaceReponseFromJson(res.body);
      _nextPageToken = spr.nextPageToken != null ? spr.nextPageToken : '';
      _placeList = spr.results;
    }

    try {
      setState(() {
        this.placeList.addAll(_placeList);
        this.nextPageToken = _nextPageToken;
        this.isLoading = false;
      });
    } catch (e) {
      print(e);
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
                  SizedBox(height: 100),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Styles.spacing),
                    child: Column(
                      children: placeWidgets(),
                    ),
                  ),
                  // Builder(
                  //   builder: (context) {
                  //     if (this.isLoading) {
                  //       // ----- NOTE: loading screen
                  //       return Align(
                  //         alignment: Alignment.center,
                  //         child: Text(
                  //           "Loading...",
                  //           style: Styles.h1Style,
                  //         ),
                  //       );
                  //     } else {
                  //       // ----- NOTE: place cards
                  //       return Container(
                  //         padding: EdgeInsets.symmetric(horizontal: Styles.spacing),
                  //         child: Column(
                  //           children: placeWidgets(),
                  //         ),
                  //       );
                  //     }
                  //   },
                  // ),
                  SizedBox(height: 7),
                  // NOTE: More Btn
                  Builder(
                    builder: (context) {
                      if (this.nextPageToken != '') {
                        return DghaTextButton(
                          minWidth: MediaQuery.of(context).size.width * 0.45,
                          text: "More",
                          textStyle: Styles.yellowTxtBtnStyle,
                          colour: Styles.midnightBlue,
                          onTap: () {
                            this._search();
                          },
                        );
                      } else {
                        return Container();
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

              // NOTE: Search Bar
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
                    setState(() {
                      this.input = value;
                    });
                    this._search();
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

    for (var i = 0; i < this.placeList.length; i++) {
      PlaceCard w = new PlaceCard(
        placeData: this.placeList[i],
      );
      widgets.add(w);
    }

    return widgets;
  }
}
