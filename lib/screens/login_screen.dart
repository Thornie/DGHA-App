import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/models/location_data.dart';
import 'package:dgha_brochure/models/review_scr_args.dart';
import 'package:dgha_brochure/screens/explore_screen.dart';
import 'package:dgha_brochure/screens/place_details_screen.dart';
import 'package:dgha_brochure/screens/user_rating_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "Login Screen";
  static const String id_start = "Login Screen Start";
  static const String id_user_rating = "Login Screen User Rating";

  //Must be false on every page except for the page that loads in the main.dart file
  //This is needed so that when the user presses the back button too many times, they don't go to an empty black screen
  final bool isStartPage;

  final bool goToReviewScreen;
  final LocationData locationData;

  LoginScreen({
    this.isStartPage = false,
    this.goToReviewScreen = false,
    this.locationData,
  });
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double loginPadding = MediaQuery.of(context).size.width * 0.05;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.symmetric(horizontal: loginPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/dgha_logo/logo.png"),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Login",
                              style: Styles.h2Style,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),

                      // NOTE: Email Text Field
                      Semantics(
                        label: "Email",
                        hint: "Double tap to enter your email address",
                        excludeSemantics: true,
                        child: Container(
                          child: buildTextField(
                              prefixIcon: FontAwesomeIcons.solidEnvelope,
                              hintText: "Email",
                              controller: _emailController,
                              onChange: (value) {
                                email = value;
                              },
                              onClear: () {
                                email = "";
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      // NOTE: Password Text Field
                      Semantics(
                        label: "Password",
                        hint: "Double tap to enter your password",
                        excludeSemantics: true,
                        child: Container(
                          child: buildTextField(
                              prefixIcon: FontAwesomeIcons.lock,
                              hintText: "Password",
                              obscureText: true,
                              controller: _passController,
                              onChange: (value) {
                                password = value;
                              },
                              onClear: () {
                                password = "";
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      // NOTE: Login Button
                      Center(
                        child: Semantics(
                          button: true,
                          label: "Sign in",
                          hint: "Double tap to sign into your account",
                          excludeSemantics: true,
                          child: GestureDetector(
                            onTap: () {
                              signIn();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Styles.midnightBlue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Styles.grey,
                                    blurRadius: 3,
                                    offset: Offset(2, 3),
                                  ),
                                ],
                              ),
                              child: Text(
                                "Sign in",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Styles.yellow,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // NOTE: Skip Button
                Center(
                  child: Semantics(
                    button: true,
                    label: "Skip",
                    hint: "Double tap to skip and sign in later",
                    excludeSemantics: true,
                    child: GestureDetector(
                      onTap: () {
                        if (widget.isStartPage)
                          Navigator.of(context).pushNamed(ExploreScreen.id);
                        else if (widget.goToReviewScreen)
                          Navigator.of(context).popAndPushNamed(
                              PlaceDetailsScreen.id,
                              arguments: widget.locationData);
                        else
                          Navigator.of(context)
                              .popAndPushNamed(ExploreScreen.id);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        margin: EdgeInsets.only(bottom: 30),
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
                        child: Text(
                          "Skip",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            decoration: TextDecoration.underline,
                            decorationThickness: 3,
                            decorationColor: Styles.midnightBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Styles.midnightBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField buildTextField(
      {IconData prefixIcon,
      String hintText,
      bool obscureText = false,
      Function(String) onChange,
      TextEditingController controller,
      Function onClear}) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        onChange(value);
      },
      onSubmitted: (val) {
        signIn();
      },
      style: Styles.inputStyle,
      cursorColor: Styles.midnightBlue,
      cursorWidth: 5,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 35, right: 25),
          child: Icon(prefixIcon),
        ),
        suffixIcon: IconButton(
          padding: EdgeInsets.only(left: 25, right: 35),
          onPressed: () {
            Future.delayed(Duration(milliseconds: 50)).then((_) {
              controller.clear();
              if (onClear() != null) onClear();
            });
          },
          icon: Icon(
            FontAwesomeIcons.times,
            color: Styles.midnightBlue,
            size: Styles.iconSize,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(color: Styles.grey, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(color: Styles.midnightBlue, width: 3),
        ),
        hintText: hintText,
        // hintStyle: TextStyle(color: Styles.)
      ),
    );
  }

  //NOTE: Sign in funciton
  void signIn() async {
    if (email != "" && password != "") {
      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (user != null) {
          if (widget.goToReviewScreen)
            Navigator.of(context).popAndPushNamed(
              UserRatingScreen.id,
              arguments: ReviewScrArgs(
                placeId: widget.locationData.placeId,
                placeName: widget.locationData.name,
              ),
            );
          else
            Navigator.of(context).popAndPushNamed(ExploreScreen.id);
        }
      } catch (exception) {
        print(exception);
      }
    } else
      print("Email or password is empty");
  }
}
