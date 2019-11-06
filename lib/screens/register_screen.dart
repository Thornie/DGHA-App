import 'package:dgha_brochure/components/dgha_text_btn.dart';
import 'package:dgha_brochure/components/header_row.dart';
import 'package:dgha_brochure/components/input_textfield.dart';
import 'package:dgha_brochure/misc/dgha_api.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/screens/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "Register Screen";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // ------------------------ NOTE: Variables
  String email;
  String passwordV1;
  String passwordV2;

  double containerHeight;
  double marginHeight;
  double buttonMinWidth;

  bool passwordMatch = true;

  @override
  void initState() {
    super.initState();
  }

  void calcDimensions() {
    double scrWidth = MediaQuery.of(context).size.width;
    double scrHeight = MediaQuery.of(context).size.height;

    this.containerHeight = scrHeight;
    this.marginHeight = scrHeight * 0.05;
    this.buttonMinWidth = scrWidth * 0.45;
  }

  void signUp() async {
    if (this.passwordV1 == this.passwordV2) {
      try {
        print("TEST: ${DghaApi.currentClient}");
        //Create Account
        final Response newUser =
            await DghaApi.postAccount(this.email, this.passwordV1);

        if (newUser.statusCode == 201) {
          //Login
          await DghaApi.signIn(this.email, this.passwordV1);
          if (DghaApi.currentClient != null) {
            Navigator.of(context).pushNamed(ExploreScreen.id);
          }
        } else {
          print("FAIL");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("passwords are different");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            calcDimensions();
            return SingleChildScrollView(
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
                          HeaderRow(text: "Sign Up"),
                          SizedBox(height: this.marginHeight * 0.7),

                          // NOTE: Email
                          Semantics(
                            textField: true,
                            label: "Email text field",
                            child: Container(
                              child: UserInputTextField(
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: FontAwesomeIcons.solidEnvelope,
                                hintText: "Email",
                                onChange: (value) {
                                  this.email = value;
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: this.marginHeight * 0.5),

                          // NOTE: Password V1
                          Semantics(
                            textField: true,
                            label: "Password text field",
                            child: Container(
                              child: UserInputTextField(
                                prefixIcon: FontAwesomeIcons.lock,
                                hintText: "Password",
                                obscureText: true,
                                onChange: (value) {
                                  this.passwordV1 = value;
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: this.marginHeight * 0.5),

                          // NOTE: Password V2
                          Semantics(
                            textField: true,
                            label: "Confirm password text field",
                            child: Container(
                              child: UserInputTextField(
                                prefixIcon: FontAwesomeIcons.lock,
                                hintText: "Confirm Password",
                                obscureText: true,
                                highlightRed: !passwordMatch,
                                onChange: (value) {
                                  this.passwordV2 = value;
                                  setState(() {
                                    if (passwordV1 != passwordV2)
                                      passwordMatch = false;
                                    else
                                      passwordMatch = true;
                                  });
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: this.marginHeight * 0.5),

                          // NOTE: Terms and Condition
                          Container(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          'By clicking "Register" you agree to the following '),
                                  TextSpan(
                                      text: 'Terms and Conditions.',
                                      style: Styles.linkStyle),
                                ],
                              ),
                              style: Styles.pStyle,
                            ),
                          ),

                          SizedBox(height: this.marginHeight * 0.5),

                          // NOTE: Register
                          Semantics(
                            button: true,
                            label: "Sign Up button",
                            hint: "Double tap to sign up",
                            child: DghaTextButton(
                              minWidth: this.buttonMinWidth,
                              text: "Sign Up",
                              textStyle: Styles.yellowTxtBtnStyle,
                              colour: Styles.midnightBlue,
                              onTap: () {
                                this.signUp();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: this.marginHeight * 0.5),

                    // NOTE: Skip
                    Semantics(
                      button: true,
                      label: "Skip button",
                      hint: "Double tap to skip sign up",
                      child: DghaTextButton(
                        minWidth: this.buttonMinWidth,
                        text: "Skip",
                        textStyle: Styles.btnTextBlueUnderlineStyle,
                        colour: Styles.yellow,
                        onTap: () {
                          Navigator.pop(context);
                          // Navigator.of(context).pushNamed(ExploreScreen.id);
                        },
                        bottomMargin: this.marginHeight * 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
