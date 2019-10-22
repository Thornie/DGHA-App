import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/screens/rating_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:dgha_brochure/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "register_screen";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmpass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          //Close the keyboard when user taps on screen
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ListView(
            children: <Widget>[
              DghaAppBar(
                isMenu: true,
                text: 'DGHA Register',
                childOne: GestureDetector(
                  child: DghaIcon(
                    size: 35,
                    padding: 4,
                    backgroundColor: Styles.midnightBlue,
                    iconColor: Styles.yellow,
                    icon: Icons.close,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Type your Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Styles.midnightBlue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Type your Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Styles.midnightBlue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextField(
                  onChanged: (value) {
                    confirmpass = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Styles.midnightBlue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text:
                              'By Clicking Sign Up you agree to the following '),
                      TextSpan(
                          text: 'Terms and Conditions',
                          style: Styles.highlightText),
                    ],
                  ),
                  style: Styles.pStyle,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Styles.midnightBlue,
                  ),
                  child: FlatButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Styles.yellow,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          Navigator.pushNamed(context, RatingMenuScreen.id);
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
