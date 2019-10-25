import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/screens/explore_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "Register Screen";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // ------------------------ NOTE: Variables
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String passwordV1;
  String passwordV2;

  double containerHeight;
  double marginHeight;

  void calcDimensions() {
    double scrHeight = MediaQuery.of(context).size.height;

    this.containerHeight = scrHeight;
    this.marginHeight = scrHeight * 0.05;
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
                    // Top margin
                    SizedBox(
                      height: this.marginHeight,
                    ),

                    // NOTE: Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/images/dgha_logo/logo.png")),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Register",
                            style: Styles.h2Style,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: this.marginHeight * 0.5,
                    ),

                    // NOTE: Email
                    Container(
                      child: buildTextField(
                        hintText: "Email",
                        onChange: (value) {
                          this.email = value;
                        },
                      ),
                    ),

                    SizedBox(
                      height: this.marginHeight * 0.5,
                    ),

                    // NOTE: Password V1
                    Container(
                      child: buildTextField(
                        hintText: "Password",
                        obscureText: true,
                        onChange: (value) {
                          this.passwordV1 = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: this.marginHeight * 0.5,
                    ),

                    // NOTE: Password V2
                    Container(
                      child: buildTextField(
                        hintText: "Confirm Password",
                        obscureText: true,
                        onChange: (value) {
                          this.passwordV2 = value;
                        },
                      ),
                    ),

                    SizedBox(
                      height: this.marginHeight * 0.5,
                    ),

                    // NOTE: Terms and Condition
                    Container(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'By clicking "Register" you agree to the following '),
                            TextSpan(text: 'Terms and Conditions.', style: Styles.highlightText),
                          ],
                        ),
                        style: Styles.pStyle,
                      ),
                    ),

                    SizedBox(
                      height: this.marginHeight * 0.5,
                    ),

                    // NOTE: Register
                    GestureDetector(
                      onTap: () async {
                        if ((this.passwordV1.isNotEmpty && this.email.isNotEmpty) && (this.passwordV1 == this.passwordV2)) {
                          try {
                            final newUser = _auth.createUserWithEmailAndPassword(email: this.email, password: this.passwordV1);

                            if (newUser != null) {
                              final loggedInUser = _auth.signInWithEmailAndPassword(email: this.email, password: this.passwordV1);

                              if (loggedInUser != null) {
                                Navigator.of(context).pushNamed(ExploreScreen.id);
                              } else {
                                print("something is wrong");
                              }
                            }
                          } catch (e) {
                            print(e);
                          }
                        } else {
                          print("passwords are different");
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Styles.midnightBlue,
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
                          "Register",
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
                  ],
                ),
              ),

              // NOTE: Skip
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ExploreScreen.id);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.only(bottom: this.marginHeight * 0.5),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  TextField buildTextField({IconData prefixIcon, String hintText, bool obscureText = false, Function(String) onChange}) {
    final TextEditingController _txtController = new TextEditingController();
    return TextField(
      controller: _txtController,
      onChanged: (value) {
        onChange(value);
      },
      style: Styles.inputStyle,
      cursorColor: Styles.midnightBlue,
      cursorWidth: 5,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefix: prefixIcon == null
            ? Padding(padding: EdgeInsets.only(left: 20))
            : Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Icon(prefixIcon),
              ),
        suffix: GestureDetector(
          onTap: () {
            Future.delayed(Duration(milliseconds: 50)).then((_) {
              _txtController.clear();
            });
          },
          child: Padding(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Icon(
              FontAwesomeIcons.times,
              color: Styles.midnightBlue,
              size: Styles.iconSize,
            ),
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
}
