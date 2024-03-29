import 'package:dgha_brochure/components/dgha_icon.dart';
import 'package:dgha_brochure/misc/styles.dart';
import 'package:flutter/material.dart';

class RatingBreadcrumbs extends StatefulWidget {
  //How many tabs to color in starting at 0
  final int maxNavPos;
  int currentNavPos;

  final Color iconColor;
  final Color backgroundColor;
  final Color highlightedIconColor;
  final Color highlightedBackgroundColor;
  final PageController controller;

  RatingBreadcrumbs({
    this.maxNavPos,
    this.currentNavPos,
    this.backgroundColor,
    this.iconColor,
    this.highlightedIconColor,
    this.highlightedBackgroundColor,
    this.controller,
  });
  @override
  _RatingBreadcrumbsState createState() => _RatingBreadcrumbsState();
}

class _RatingBreadcrumbsState extends State<RatingBreadcrumbs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 2, color: Styles.midnightBlue),
          left: BorderSide(width: 2, color: Styles.midnightBlue),
        ),
      ),
      height: 60,
      child: Stack(
        children: <Widget>[
          //----------Line
          Center(
            child: Container(
              height: 3,
              color: Styles.midnightBlue,
            ),
          ),
          //----------Dots
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //----------Overall Rating
                Semantics(
                  label: "Overall Rating",
                  hint: widget.maxNavPos >= 0
                      ? "Double tap to go to the overall rating page"
                      : "",
                  excludeSemantics: true,
                  child: GestureDetector(
                    child: DghaIcon(
                      padding: 3,
                      paddingPadding: 0,
                      size: 37,
                      backgroundColor: widget.maxNavPos >= 0
                          ? widget.highlightedBackgroundColor
                          : widget.backgroundColor,
                      icon: Icons.arrow_forward,
                      iconColor: widget.currentNavPos == 0
                          ? widget.highlightedIconColor
                          : widget.iconColor,
                    ),
                    onTap: widget.maxNavPos >= 0
                        ? () {
                            setState(() {
                              widget.currentNavPos = 0;
                            });
                            widget.controller.jumpToPage(0);
                          }
                        : null,
                  ),
                ),
                //----------Customer Service
                Semantics(
                  label: "Customer Service Rating",
                  hint: widget.maxNavPos >= 1
                      ? "Double tap to go to the customer service rating page"
                      : "",
                  excludeSemantics: true,
                  child: GestureDetector(
                    child: DghaIcon(
                      padding: 3,
                      paddingPadding: 0,
                      size: 37,
                      backgroundColor: widget.maxNavPos >= 1
                          ? widget.highlightedBackgroundColor
                          : widget.backgroundColor,
                      icon: Icons.arrow_forward,
                      iconColor: widget.currentNavPos == 1
                          ? widget.highlightedIconColor
                          : widget.iconColor,
                    ),
                    onTap: widget.maxNavPos >= 1
                        ? () {
                            setState(() {
                              widget.currentNavPos = 1;
                            });
                            widget.controller.jumpToPage(1);
                          }
                        : null,
                  ),
                ),
                //----------Amenities
                Semantics(
                  label: "Amenities Raint",
                  hint: widget.maxNavPos >= 2
                      ? "Double tap to go to the overall rating page"
                      : "",
                  excludeSemantics: true,
                  child: GestureDetector(
                    child: DghaIcon(
                      padding: 3,
                      paddingPadding: 0,
                      size: 37,
                      backgroundColor: widget.maxNavPos >= 2
                          ? widget.highlightedBackgroundColor
                          : widget.backgroundColor,
                      icon: Icons.arrow_forward,
                      iconColor: widget.currentNavPos == 2
                          ? widget.highlightedIconColor
                          : widget.iconColor,
                    ),
                    onTap: widget.maxNavPos >= 2
                        ? () {
                            setState(() {
                              widget.currentNavPos = 2;
                            });
                            widget.controller.jumpToPage(2);
                          }
                        : null,
                  ),
                ),
                //----------Location
                Semantics(
                  label: "Location Rating",
                  hint: widget.maxNavPos >= 3
                      ? "Double tap to go to the location service rating page"
                      : "",
                  excludeSemantics: true,
                  child: GestureDetector(
                    child: DghaIcon(
                      padding: 3,
                      paddingPadding: 0,
                      size: 37,
                      backgroundColor: widget.maxNavPos >= 3
                          ? widget.highlightedBackgroundColor
                          : widget.backgroundColor,
                      icon: Icons.arrow_forward,
                      iconColor: widget.currentNavPos == 3
                          ? widget.highlightedIconColor
                          : widget.iconColor,
                    ),
                    onTap: widget.maxNavPos >= 3
                        ? () {
                            setState(() {
                              widget.currentNavPos = 3;
                            });
                            widget.controller.jumpToPage(3);
                          }
                        : null,
                  ),
                ),
                //----------Comment
                Semantics(
                  label: "Comment Page",
                  hint: widget.maxNavPos >= 4
                      ? "Double tap to go to the additonal comment page"
                      : "",
                  excludeSemantics: true,
                  child: GestureDetector(
                    child: DghaIcon(
                      padding: 3,
                      paddingPadding: 0,
                      size: 37,
                      backgroundColor: widget.maxNavPos >= 4
                          ? widget.highlightedBackgroundColor
                          : widget.backgroundColor,
                      icon: Icons.arrow_forward,
                      iconColor: widget.currentNavPos == 4
                          ? widget.highlightedIconColor
                          : widget.iconColor,
                    ),
                    onTap: widget.maxNavPos >= 4
                        ? () {
                            setState(() {
                              widget.currentNavPos = 4;
                            });
                            widget.controller.jumpToPage(4);
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
