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
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            CircleAvatar(
              maxRadius: 50,
              child: Icon(Icons.person_add),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
              child: TextField(
                onChanged: (value) {
                  email = value;
                },
                cursorColor: Colors.deepOrange,
                decoration: InputDecoration(
                  hintText: 'Type your Email',
                  prefixIcon: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
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
                cursorColor: Colors.deepOrange,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Type your password',
                  prefixIcon: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
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
                  hintText: 'Confirm password',
                  prefixIcon: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: Icon(
                      Icons.lock,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Already have an Account ?',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: Text(
                    'LogIn ',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: 'By Clicking Sign Up you agree to the following '),
                TextSpan(
                    text: 'Terms and Conditions',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.indigo)),
              ])),
            ),
            SizedBox(
              height: 30.0,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                color: Color(0xffff3a5a),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Sign Up'.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
