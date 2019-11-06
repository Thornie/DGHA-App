import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/components/dgha_text_btn.dart';
import 'package:dgha_brochure/misc/dgha_api.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/location_data.dart';
import 'package:dgha_brochure/screens/place_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class ReportScreen extends StatefulWidget {
  static const id = "Report Screen";
  final LocationData locationData;

  ReportScreen(this.locationData);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController _txtController = new TextEditingController();

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

                  SizedBox(height: Styles.spacing),

                  // --------- NOTE: Comment
                  Container(
                    child: Text(
                      "Comment",
                      style: Styles.h3Style,
                    ),
                  ),
                  Semantics(
                    label: "Comment",
                    hint:
                        "Double tap to give more information on why you're reporting ${widget.locationData.name}",
                    excludeSemantics: true,
                    child: TextField(
                      controller: _txtController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 7,
                      maxLength: 140,
                      style: Styles.pStyle,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // --------- NOTE: Submit Button
                  Container(
                    child: DghaTextButton(
                      minWidth: MediaQuery.of(context).size.width * 0.45,
                      text: "Submit",
                      textStyle: Styles.yellowTxtBtnStyle,
                      colour: Styles.midnightBlue,
                      onTap: () async {
                        Response response = await DghaApi.postComplaint(
                          widget.locationData.placeId,
                          _txtController.text,
                        );

                        if (response.statusCode == 201) {
                          Navigator.of(context).pop();
                          print("Report Sent!");
                        } else {
                          print("Error: ${response.statusCode}");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ---- NOTE: App Bar
            DghaAppBar(
              text: "Report",
              isMenu: true,
              semanticLabel: "Report ${widget.locationData.name}",
              childOne: Semantics(
                button: true,
                label: "Menu",
                hint: "Double tap to go back and cancel the report",
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(PlaceDetailsScreen.id,
                        arguments: widget.locationData);
                  },
                  child: DghaIcon(
                    icon: FontAwesomeIcons.arrowLeft,
                    backgroundColor: Styles.midnightBlue,
                    iconColor: Styles.yellow,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
