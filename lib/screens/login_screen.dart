import 'package:dgha_brochure/components/dgha_text_btn.dart';
import 'package:dgha_brochure/components/header_row.dart';
import 'package:dgha_brochure/components/input_textfield.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/screens/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "Login Screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ------------------------ NOTE: Variables
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

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
        Navigator.of(context).pushNamed(ExploreScreen.id);
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
        child: Container(
          height: this.containerHeight,
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
                    Container(
                      child: UserInputTextField(
                        prefixIcon: FontAwesomeIcons.solidEnvelope,
                        hintText: "Email",
                        onChange: (value) {
                          email = value;
                        },
                      ),
                    ),

                    SizedBox(height: this.marginHeight * 0.5),

                    // NOTE: Password Text Field
                    Container(
                      child: UserInputTextField(
                        prefixIcon: FontAwesomeIcons.lock,
                        hintText: "Password",
                        obscureText: true,
                        onChange: (value) {
                          password = value;
                        },
                      ),
                    ),

                    SizedBox(height: this.marginHeight * 0.5),

                    // NOTE: Login
                    DghaTextButton(
                      minWidth: this.buttonMinWidth,
                      text: "Sign In",
                      textStyle: Styles.btnTxtYellowStyle,
                      colour: Styles.midnightBlue,
                      onTap: () {
                        this.signIn();
                      },
                    )
                  ],
                ),
              ),

              // NOTE: Skip Button
              DghaTextButton(
                minWidth: this.buttonMinWidth,
                text: "Skip",
                textStyle: Styles.btnTextBlueUnderlineStyle,
                colour: Styles.yellow,
                onTap: () {
                  Navigator.of(context).pushNamed(ExploreScreen.id);
                },
                bottomMargin: this.marginHeight * 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
