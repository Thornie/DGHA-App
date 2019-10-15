import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

//The component for each rating page (overall, customer service, etc)
class RatingScreenSection extends StatefulWidget {
  final String title;
  final String buttonTitle;
  final Function onPressed;
  double rating;

  RatingScreenSection(
      {this.title, this.buttonTitle = "Next", this.onPressed, this.rating = 0});

  @override
  _RatingScreenSectionState createState() => _RatingScreenSectionState();
}

class _RatingScreenSectionState extends State<RatingScreenSection> {
  @override
  Widget build(BuildContext context) {
    double localRating = widget.rating;

    return Column(
      children: <Widget>[
        Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //----------Title
              Text(
                widget.title,
                style: Styles.h2Style,
              ),
              Stack(
                children: <Widget>[
                  //----------Star Rating
                  SmoothStarRating(
                    allowHalfRating: false,
                    onRatingChanged: (v) {
                      setState(() {
                        localRating = v;
                        widget.rating = localRating;
                      });
                    },
                    starCount: 5,
                    rating: localRating,
                    size: MediaQuery.of(context).size.height / 9,
                    color: Styles.yellow,
                    borderColor: Styles.midnightBlue,
                    spacing: 0.0,
                  ),
                  //----------Star Rating Outline (Needed for the outline to stay a separate color)
                  IgnorePointer(
                    child: SmoothStarRating(
                      allowHalfRating: false,
                      starCount: 5,
                      size: MediaQuery.of(context).size.height / 9,
                      color: Styles.midnightBlue,
                      borderColor: Styles.midnightBlue,
                      spacing: 0.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        //----------Next Button
        RaisedButton(
            child: Text(
              widget.buttonTitle,
              style: Styles.h3Style,
            ),
            color: Colors.white,
            elevation: 5,
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 50, right: 50),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(20.0),
            ),
            onPressed: widget.onPressed),
      ],
    );
  }
}

class CommentSection extends StatefulWidget {
  final String title;
  final Function onPressed;
  final TextEditingController controller;

  CommentSection({this.title, this.onPressed, this.controller});

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //----------Title
                Text(
                  widget.title,
                  style: Styles.h2Style,
                ),
                //----------Comment Box
                TextField(
                  controller: widget.controller,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 7,
                  style: Styles.h3Style,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //----------Submit Button
        RaisedButton(
            child: Text(
              "Submit",
              style: Styles.h3Style,
            ),
            color: Colors.white,
            elevation: 5,
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 50, right: 50),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(20.0),
            ),
            onPressed: widget.onPressed),
      ],
    );
  }
}
