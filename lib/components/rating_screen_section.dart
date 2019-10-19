import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

//The component for each rating page (overall, customer service, etc)
class RatingScreenSection extends StatefulWidget {
  final String title;
  final String buttonTitle;
  final Function onPressed;
  final String hintText;
  double rating;

  RatingScreenSection(
      {this.title,
      this.buttonTitle = "Next",
      this.onPressed,
      this.rating = 0,
      this.hintText = ""});

  @override
  _RatingScreenSectionState createState() => _RatingScreenSectionState();
}

class _RatingScreenSectionState extends State<RatingScreenSection> {
  //Popup dialog box
  Future<String> createAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            widget.hintText,
            style: Styles.h3Style,
          ),
          actions: <Widget>[
            Semantics(
              label: "Close button",
              hint: "Double tap to close the hint pop up",
              child: MaterialButton(
                child: Text(
                  "Close",
                  style: Styles.h2Style,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //----------Title
                  Text(
                    widget.title,
                    style: Styles.h2Style,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  //----------More Info
                  Container(
                    height: 35,
                    child: Semantics(
                      label: "Hint button",
                      hint: "Double tap to open the hint pop up",
                      child: FloatingActionButton(
                        heroTag: null,
                        backgroundColor: Styles.midnightBlue,
                        child: Icon(
                          FontAwesomeIcons.question,
                          color: Styles.yellow,
                          size: 25,
                        ),
                        onPressed: () {
                          createAlertDialog(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
                  //----------Star Rating
                  Semantics(
                    label: "Rating",
                    hint: "Double tap a star to give a rating out of 5",
                    child: SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {
                        setState(() {
                          localRating = v;
                          widget.rating = localRating;
                        });
                      },
                      starCount: 5,
                      rating: localRating,
                      size: MediaQuery.of(context).size.width / 6,
                      color: Styles.yellow,
                      borderColor: Styles.midnightBlue,
                      spacing: 0.0,
                    ),
                  ),
                  //----------Star Rating Outline (Needed for the outline to stay a separate color)
                  IgnorePointer(
                    child: SmoothStarRating(
                      allowHalfRating: false,
                      starCount: 5,
                      size: MediaQuery.of(context).size.width / 6,
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
        Semantics(
          label: "Next button",
          hint: "Double tap to go to the next rating page",
          child: RaisedButton(
              child: Text(
                widget.buttonTitle,
                style: Styles.h3Style,
              ),
              color: Colors.white,
              elevation: 5,
              padding:
                  EdgeInsets.only(top: 15, bottom: 15, left: 50, right: 50),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: widget.onPressed),
        ),
      ],
    );
  }
}

class CommentSection extends StatefulWidget {
  final String title;
  final Function onPressed;
  final TextEditingController controller;
  final String hintText;

  CommentSection(
      {this.title, this.onPressed, this.controller, this.hintText = ""});

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  //Popup dialog box
  Future<String> createAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            widget.hintText,
            style: Styles.h3Style,
          ),
          actions: <Widget>[
            Semantics(
              label: "Close button",
              hint: "Double tap to close the hint pop up",
              child: MaterialButton(
                child: Text(
                  "Close",
                  style: Styles.h2Style,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //----------Title
                    Text(
                      widget.title,
                      style: Styles.h2Style,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //----------More Info
                    Container(
                      height: 35,
                      child: Semantics(
                        label: "Hint button",
                        hint: "Double tap to open the hint pop up",
                        child: FloatingActionButton(
                          heroTag: null,
                          backgroundColor: Styles.midnightBlue,
                          child: Icon(
                            FontAwesomeIcons.question,
                            color: Styles.yellow,
                            size: 25,
                          ),
                          onPressed: () {
                            createAlertDialog(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                //----------Comment Box
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Semantics(
                    label: "Comment",
                    hint:
                        "Double tap to leave a comment on your experience at this location",
                    child: TextField(
                      controller: widget.controller,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 7,
                      maxLength: 140,
                      style: Styles.pStyle,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        //----------Submit Button
        Semantics(
          label: "Submit button",
          hint: "Double tap to submit your review of this location",
          child: RaisedButton(
              child: Text(
                "Submit",
                style: Styles.h3Style,
              ),
              color: Colors.white,
              elevation: 5,
              padding:
                  EdgeInsets.only(top: 15, bottom: 15, left: 50, right: 50),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: widget.onPressed),
        ),
      ],
    );
  }
}
