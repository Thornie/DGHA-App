import 'package:dgha_brochure/components/bottom_navigation.dart';
import 'package:dgha_brochure/components/dgha_text_btn.dart';
import 'package:dgha_brochure/components/input_textfield.dart';
import 'package:dgha_brochure/components/loading_text.dart';
import 'package:dgha_brochure/components/place_card.dart';
import 'package:dgha_brochure/misc/helper.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/place.dart';
import 'package:dgha_brochure/models/search_response.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

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
  bool isFirstLoad = true;

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
        this.isFirstLoad = false;
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
                  // ------------------------------- NOTE: Place Cards
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Styles.spacing),
                    child: Column(
                      children: this.placeList.map((place) => PlaceCard(placeData: place,)).toList()
                    ),
                  ),
                  SizedBox(height: 7),
                  // ------------------------------- NOTE: MORE button
                  buildMoreBtn(),
                  SizedBox(height: 80)
                ],
              ),
              Container(
                height: 60,
                width: double.infinity,
                color: Color(0xffFAFAFA),
              ),
              // ------------------------------------ NOTE: Search Bar
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
                      this.placeList.clear();
                      this.nextPageToken = '';
                    });
                    this._search();
                  },
                  changeFocusColour: false,
                ),
              ),
              // ----------------------------------- NOTE: Big Loading Text
              LoadingText(condition: this.isLoading && this.placeList.isEmpty)
            ]),
          ),
        ),
      ),

      // ------------------------------------------- NOTE: Bottom Nav Bar
      bottomNavigationBar: DGHABotNav(activeTab: ActivePageEnum.ratingsPage),
    );
  }

  Builder buildMoreBtn() {
    return Builder(
      builder: (context) {
        if (this.nextPageToken != '') {
          return DghaTextButton(
            minWidth: MediaQuery.of(context).size.width * 0.45,
            text: this.isLoading ? "Loading . . ." : "View More",
            textStyle: this.isLoading ? Styles.blackTxtBtnStyle : Styles.yellowTxtBtnStyle,
            colour: this.isLoading ? Colors.grey : Styles.midnightBlue,
            onTap: () {
              this.isLoading ? null : this._search(); 
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
