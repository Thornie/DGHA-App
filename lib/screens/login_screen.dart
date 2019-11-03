import 'package:dgha_brochure/components/dgha_text_btn.dart';
import 'package:dgha_brochure/components/header_row.dart';
import 'package:dgha_brochure/components/input_textfield.dart';
import 'package:dgha_brochure/misc/data.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/location_data.dart';
import 'package:dgha_brochure/models/review_scr_args.dart';
import 'package:dgha_brochure/screens/explore_screen.dart';
import 'package:dgha_brochure/screens/user_rating_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "Login Screen";
  static const String id_user_rating = "Login Screen User Rating";

  //Must be false on every page except for the page that loads in the main.dart file
  //This is needed so that when the user presses the back button too many times, they don't go to an empty black screen

  final bool goToReviewScreen;
  final LocationData locationData;

  LoginScreen({
    this.goToReviewScreen = false,
    this.locationData,
  });

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ------------------------ NOTE: Variables
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";

  double containerHeight;
  double marginHeight;
  double buttonMinWidth;

  void calcDimensions() {
    double scrWidth = MediaQuery.of(context).size.width;
    double scrHeight = MediaQuery.of(context).size.height;

    this.containerHeight = scrHeight;
    this.marginHeight = scrHeight * 0.05;
    this.buttonMinWidth = scrWidth * 0.45;
  }

  void signIn() async {
    try {
      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (user != null) {
        if (widget.goToReviewScreen)
          Navigator.of(context).popAndPushNamed(
            UserRatingScreen.id,
            arguments: ReviewScrArgs(
              placeId: widget.locationData.placeId,
              placeName: widget.locationData.name,
            ),
          );
        else {
          Navigator.of(context).popAndPushNamed(ExploreScreen.id);
        }
      }
    } catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    calcDimensions();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Styles.spacing),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: this.marginHeight * 0.5),
                      HeaderRow(text: "Sign In"),
                      SizedBox(height: this.marginHeight * 0.7),

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
                          colour: Styles.midnightBlue,
                          onTap: () {
                            this.signIn();
                          },
                        ),
                      )
                    ],
                  ),
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
        ),
      ),
    );
  }
}
