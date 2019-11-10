import 'package:dgha_brochure/components/input_textfield.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String id = "Search Screen";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
              child: ListView(
            children: <Widget>[
              // ---- TODO: Search
              UserInputTextField(
                hintText: "Search place name",
              ),

              // ---- TODO: Search Results
            ],
          )),
        ),
      ),
    );
  }
}
