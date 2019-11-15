import 'package:dgha/components/dgha_icon.dart';
import 'package:dgha/components/dgha_star_rating.dart';
import 'package:dgha/misc/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//The component for each rating page (overall, customer service, etc)
class UserRatingContainer extends StatefulWidget {
  final String title;
  final String buttonTitle;
  final Function onPressed;
  final String hintText;
  double rating;

  UserRatingContainer({
    this.title,
    this.buttonTitle = "Next",
    this.onPressed,
    this.rating = 0,
    this.hintText = "",
  });

  @override
  _UserRatingContainerState createState() => _UserRatingContainerState();
}

class _UserRatingContainerState extends State<UserRatingContainer> {
  // Lee: Can't get out of dialog box when using screen reader.
  //Popup dialog box
  // Future<String> createAlertDialog(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         content: Text(
  //           widget.hintText,
  //           style: Styles.pStyle,
  //         ),
  //         actions: <Widget>[
  //           Semantics(
  //             button: true,
  //             label: "Close button",
  //             hint: "Double tap to close the hint pop up",
  //             excludeSemantics: true,
  //             child: GestureDetector(
  //               child: Container(
  //                 width: 100,
  //                 padding: EdgeInsets.symmetric(vertical: 10),
  //                 decoration: BoxDecoration(
  //                   color: Styles.midnightBlue,
  //                   borderRadius: BorderRadius.all(Radius.circular(50)),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Styles.grey,
  //                       blurRadius: 3,
  //                       offset: Offset(2, 3),
  //                     ),
  //                   ],
  //                 ),
  //                 child: Text(
  //                   "Close",
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                     color: Styles.yellow,
  //                     fontFamily: "Poppins",
  //                     fontWeight: FontWeight.w700,
  //                     fontSize: 20,
  //                   ),
  //                 ),
  //               ),
  //               onTap: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      explicitChildNodes: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          // ------------------------- NOTE: Title of Rating and Hint
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //---------- NOTE: Title
              Text(
                widget.title,
                style: Styles.h2Style,
              ),
              SizedBox(
                width: 15,
              ),
              //---------- NOTE: More Info
              // Container(
              //   height: 50,
              //   child: Semantics(
              //     button: true,
              //     label: "Hint button",
              //     hint: "Double tap to open the hint pop up",
              //     excludeSemantics: true,
              //     child: GestureDetector(
              //       child: DghaIcon(
              //         icon: FontAwesomeIcons.question,
              //         iconColor: Styles.yellow,
              //         backgroundColor: Styles.midnightBlue,
              //         size: 30,
              //         padding: 6,
              //         paddingPadding: 4,
              //       ),
              //       onTap: () {
              //         createAlertDialog(context);
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              DghaStarRating(
                height: MediaQuery.of(context).size.width / 7,
                rating: widget.rating,
                starCount: 5,
                onTap: (rating) {
                  widget.rating = rating;
                },
              ),
              SizedBox(
                height: 35,
              ),
              //----------Next Button
              GestureDetector(
                onTap: widget.onPressed,
                child: Semantics(
                  label: "Next",
                  hint: "Double tap to go to the next page",
                  excludeSemantics: true,
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
                      "Next",
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
        ],
      ),
    );
  }
}

class CommentSection extends StatefulWidget {
  final String title;
  final Function onPressed;
  final TextEditingController controller;
  final String hintText;
  Color btnColor;

  CommentSection({this.title, this.onPressed, this.controller, this.hintText = "", this.btnColor});

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
            style: Styles.pStyle,
          ),
          actions: <Widget>[
            Semantics(
              button: true,
              label: "Close button",
              hint: "Double tap to close the hint pop up",
              excludeSemantics: true,
              child: GestureDetector(
                child: Container(
                  width: 100,
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
                    "Close",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Styles.yellow,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
                onTap: () {
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
    Color color = widget.btnColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Column(
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
                    width: 15,
                  ),
                  //----------More Info
                  Container(
                    height: 50,
                    child: Semantics(
                      button: true,
                      label: "Hint button",
                      hint: "Double tap to open the hint pop up",
                      excludeSemantics: true,
                      child: GestureDetector(
                        child: DghaIcon(
                          icon: FontAwesomeIcons.question,
                          iconColor: Styles.yellow,
                          backgroundColor: Styles.midnightBlue,
                          size: 30,
                          padding: 6,
                          paddingPadding: 4,
                        ),
                        onTap: () {
                          createAlertDialog(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //----------Comment Box
              Semantics(
                label: "Comment",
                hint: "Double tap to leave a comment on your experience at this location",
                excludeSemantics: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
              SizedBox(
                height: 15,
              ),
              //----------Submit Button
              GestureDetector(
                onTap: widget.onPressed,
                child: Semantics(
                  label: "Submit",
                  hint: "Double tap to submit your review",
                  excludeSemantics: true,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: color,
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
                      "Submit",
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
      ],
    );
  }
}
