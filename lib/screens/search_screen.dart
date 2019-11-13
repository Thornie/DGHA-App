import 'package:dgha_brochure/components/bottom_navigation.dart';
import 'package:dgha_brochure/components/input_textfield.dart';
import 'package:dgha_brochure/components/loading_text.dart';
import 'package:dgha_brochure/components/place_card.dart';
import 'package:dgha_brochure/components/view_more_btn.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/place.dart';
import 'package:dgha_brochure/models/search_response.dart';
import 'package:dgha_brochure/services/place_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  static const String id = "Search Screen";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // ------------------------- NOTE: Variables
  SearchPlace searchPlace = new SearchPlace(places: List<PlaceData>(), nextPageToken: '');
  String input;
  bool isLoading = false;
  bool isFirstLoad = true;

  // ------------------------- NOTE: Get Place
  void _search() async {
    setState(() {
      this.isLoading = true;
    });

    SearchPlace _spr = await PlaceService.getSearchedPlaces(this.input, this.searchPlace.nextPageToken);

    try {
      setState(() {
        this.searchPlace.places.addAll(_spr.places);
        this.searchPlace.nextPageToken = _spr.nextPageToken;
        this.isLoading = false;
        this.isFirstLoad = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: <Widget>[
          // ------------------------------- NOTE: Body
          ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 100),

              // ------------------------- NOTE: Place Cards
              Container(
                padding: EdgeInsets.symmetric(horizontal: Styles.spacing),
                child: Column(
                  children: this.searchPlace.places.map((place) => PlaceCard(placeData: place,)).toList(),
                ),
              ),

              SizedBox(height: 7),

              // ------------------------- NOTE: MORE button
              ViewMoreBtn(
                condition: this.searchPlace.nextPageToken != '',
                loadingCondition: this.isLoading,
                onTap: this._search,
              ),

              SizedBox(height: Styles.spacing)
            ],
          ),

          // ------- hide the placeCards when scrolling up
          Container(height: 60, width: double.infinity, color: Color(0xffFAFAFA)),

          // ------------------------- NOTE: Search Bar
          buildSearchBar(),

          // ------------------------- NOTE: Big Loading Text
          LoadingText(condition: this.isLoading && (this.isFirstLoad || this.searchPlace.places.isEmpty))
        ]),
      ),

      // ----------------------------- NOTE: Bottom Nav Bar
      bottomNavigationBar: DGHABotNav(activeTab: ActivePageEnum.ratingsPage),
    );
  }

  Widget buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(Styles.spacing),
      child: UserInputTextField(
        prefixIcon: FontAwesomeIcons.arrowLeft,
        hintText: "Search place name",
        autoFocus: true,
        prefixOnTap: () {
          Navigator.pop(context);
        },
        onSubmit: (value) {

          // empty out values for the new place
          setState(() {
            this.input = value;
            this.searchPlace.places.clear();
            this.searchPlace.nextPageToken = '';
          });
          
          this._search();
        },
        changeFocusColour: false,
      ),
    );
  }
}
