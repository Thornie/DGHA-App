import 'package:dgha_brochure/screens/rating_menu_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:dgha_brochure/screens/register_screen.dart';

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
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Text(
              'Welcome to DGHA',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
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
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
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
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Color(0xffff3a5a)),
                child: FlatButton(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
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
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Don\'t have an Account ?',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.normal),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterScreen.id);
                  },
                  child: Text(
                    'Sign Up ',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'or',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FacebookSignInButton(
                  onPressed: () {},
                ),
                SizedBox(
                  height: 12.0,
                ),
                GoogleSignInButton(
                  darkMode: true,
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
