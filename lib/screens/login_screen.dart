import 'package:dgha_brochure/components/appbar.dart';
import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/screens/rating_menu_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                text: 'DGHA Login',
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
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
                child: TextField(
                  onChanged: (value) {
                    password = value;
                  },
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
                height: 50,
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
                      'Login',
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
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
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
              ),
              //---------- Not using google or facebook to sign in yet
              // SizedBox(
              //   height: 20.0,
              // ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: <Widget>[
              //     FacebookSignInButton(
              //       onPressed: () {},
              //     ),
              //     SizedBox(
              //       height: 12.0,
              //     ),
              //     GoogleSignInButton(
              //       darkMode: true,
              //       onPressed: () {
              //         setState(() {});
              //       },
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
