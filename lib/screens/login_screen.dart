import 'package:dgha_brochure/components/dgha_text_btn.dart';
import 'package:dgha_brochure/components/header_row.dart';
import 'package:dgha_brochure/components/input_textfield.dart';
import 'package:dgha_brochure/misc/data.dart';
import 'package:dgha_brochure/misc/dgha_api.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/location_data.dart';
import 'package:dgha_brochure/models/review_scr_args.dart';
import 'package:dgha_brochure/screens/explore_screen.dart';
import 'package:dgha_brochure/screens/report_screen.dart';
import 'package:dgha_brochure/screens/user_rating_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "Login Screen";
  static const String id_user_rating = "Login Screen User Rating";
  static const String id_report = "Login Screen Report";

  //Must be false on every page except for the page that loads in the main.dart file
  //This is needed so that when the user presses the back button too many times, they don't go to an empty black screen

  final bool goToReviewScreen;
  final bool goToReportScreen;
  final LocationData locationData;

  LoginScreen({
    this.goToReviewScreen = false,
    this.goToReportScreen = false,
    this.locationData,
  });

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ------------------------ NOTE: Variables
  String email = "";
  String password = "";
  String loadingText = "Connecting...";

  double containerHeight;
  double marginHeight;
  double buttonMinWidth;

  bool isLoading = false;
  bool showLoadingText = false;

  void calcDimensions() {
    double scrWidth = MediaQuery.of(context).size.width;
    double scrHeight = MediaQuery.of(context).size.height;

    this.containerHeight = scrHeight;
    this.marginHeight = scrHeight * 0.05;
    this.buttonMinWidth = scrWidth * 0.45;
  }

  void signIn() async {
    setState(() {
      this.loadingText = "Connecting...";
      this.showLoadingText = true;
      this.isLoading = true;
    });
    try {
      await DghaApi.signIn(this.email, this.password);

      if (DghaApi.currentClient != null) {
        if (widget.goToReviewScreen) {
          await Navigator.of(context).popAndPushNamed(
            UserRatingScreen.id,
            arguments: ReviewScrArgs(
              placeId: widget.locationData.placeId,
              placeName: widget.locationData.name,
            ),
          );
          setState(() {
            this.isLoading = false;
            this.showLoadingText = false;
          });
        } else if (widget.goToReportScreen) {
          await Navigator.of(context).popAndPushNamed(
            ReportScreen.id,
            arguments: widget.locationData,
          );
          setState(() {
            this.isLoading = false;
            this.showLoadingText = false;
          });
        } else {
          await Navigator.of(context).popAndPushNamed(ExploreScreen.id);
          setState(() {
            this.isLoading = false;
            this.showLoadingText = false;
          });
        }
      }
    } catch (exception) {
      setState(() {
        if (exception.description == "invalid_username_or_password") {
          this.loadingText = "Incorrent username or password";
        } else {
          this.isLoading = exception.description;
        }
        this.isLoading = false;
      });
    }
  }

  Widget buildLoadingWidget() {
    if (this.showLoadingText) {
      return Container(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            this.loadingText,
            style: Styles.h2Style,
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
          calcDimensions();
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Styles.spacing),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(height: this.marginHeight * 0.5),
                          HeaderRow(text: "Sign In"),
                          SizedBox(height: this.marginHeight * 0.7),

                          // NOTE: Connecting Text
                          buildLoadingWidget(),

                          SizedBox(
                            height: this.marginHeight * 0.5,
                          ),

                          // NOTE: Email
                          Semantics(
                            label: "Email",
                            hint: "Double tap to enter your email address",
                            excludeSemantics: true,
                            child: Container(
                              child: UserInputTextField(
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: FontAwesomeIcons.solidEnvelope,
                                hintText: "Email",
                                onChange: (value) {
                                  email = value;
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: this.marginHeight * 0.5),

                          // NOTE: Password Text Field
                          Semantics(
                            label: "Password",
                            hint: "Double tap to enter your password",
                            child: Container(
                              child: UserInputTextField(
                                prefixIcon: FontAwesomeIcons.lock,
                                hintText: "Password",
                                obscureText: true,
                                onChange: (value) {
                                  password = value;
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: this.marginHeight * 0.5),

                          // NOTE: Login
                          Semantics(
                            label: "Sign In",
                            hint: "Double tap to sign into your account",
                            child: DghaTextButton(
                              minWidth: this.buttonMinWidth,
                              text: "Sign In",
                              textStyle: Styles.yellowTxtBtnStyle,
                              colour: this.isLoading
                                  ? Styles.grey
                                  : Styles.midnightBlue,
                              onTap: () {
                                if (this.email != "" &&
                                    this.password != "" &&
                                    this.isLoading == false) {
                                  this.signIn();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: this.marginHeight * 0.5),

                  // NOTE: Skip Button
                  Semantics(
                    label: "Skip",
                    hint: "Double tap to skip sign in",
                    child: DghaTextButton(
                      minWidth: this.buttonMinWidth,
                      text: "Skip",
                      textStyle: Styles.btnTextBlueUnderlineStyle,
                      colour: Styles.yellow,
                      onTap: () {
                        if (Data.pages.length == 0) {
                          Navigator.popAndPushNamed(context, ExploreScreen.id);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      bottomMargin: this.marginHeight * 0.5,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
