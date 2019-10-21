import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/screens/rating_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "Login Screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    double loginPadding = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
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
                          image: DecorationImage(image: AssetImage("assets/images/dgha_logo/logo.png")),
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
                  Container(
                    child: buildTextField(
                      prefixIcon: FontAwesomeIcons.solidEnvelope,
                      hintText: "Email",
                      onChange: (value) {
                        email = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  // NOTE: Password Text Field
                  Container(
                    child: buildTextField(
                      prefixIcon: FontAwesomeIcons.lock,
                      hintText: "Password",
                      obscureText: true,
                      onChange: (value) {
                        password = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  // NOTE: Login Button
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                          if (user != null) {
                            Navigator.of(context).pushNamed(RatingMenuScreen.id);
                          }
                        } catch (exception) {
                          print(exception);
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
                ],
              ),
            ),

            // NOTE: Skip Button
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(RatingMenuScreen.id);
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
            )
          ],
        ),
      )),
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
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 35, right: 25),
          child: Icon(prefixIcon),
        ),
        suffixIcon: IconButton(
          padding: EdgeInsets.only(left: 25, right: 35),
          onPressed: () {
            Future.delayed(Duration(milliseconds: 50)).then((_) {
              _txtController.clear();
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
}
