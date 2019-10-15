import 'package:flutter/material.dart';

class RatingBreadcrumbs extends StatefulWidget {
  //How many tabs to color in starting at 0
  final int navPosition;

  final Color iconColor;
  final Color backgroundColor;
  final Color highlightedIconColor;
  final Color highlightedBackgroundColor;
  final PageController controller;

  RatingBreadcrumbs(
      {this.navPosition,
      this.backgroundColor,
      this.iconColor,
      this.highlightedIconColor,
      this.highlightedBackgroundColor,
      this.controller});
  @override
  _RatingBreadcrumbsState createState() => _RatingBreadcrumbsState();
}

class _RatingBreadcrumbsState extends State<RatingBreadcrumbs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 2, color: Colors.black),
          left: BorderSide(width: 2, color: Colors.black),
        ),
      ),
      height: 40,
      child: Stack(
        children: <Widget>[
          //----------Line
          Center(
            child: Container(
              height: 2,
              color: Colors.black,
            ),
          ),
          //----------Dots
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //----------Overall Rating
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: widget.navPosition >= 0
                      ? widget.highlightedBackgroundColor
                      : widget.backgroundColor,
                  child: Icon(
                    Icons.arrow_forward,
                    color: widget.navPosition >= 0
                        ? widget.highlightedIconColor
                        : widget.iconColor,
                    size: 35,
                  ),
                  onPressed: widget.navPosition >= 0
                      ? () {
                          widget.controller.jumpToPage(0);
                        }
                      : null,
                ),
                //----------Customer Service
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: widget.navPosition >= 1
                      ? widget.highlightedBackgroundColor
                      : widget.backgroundColor,
                  child: Icon(
                    Icons.arrow_forward,
                    color: widget.navPosition >= 1
                        ? widget.highlightedIconColor
                        : widget.iconColor,
                    size: 35,
                  ),
                  onPressed: widget.navPosition >= 1
                      ? () {
                          widget.controller.jumpToPage(1);
                        }
                      : null,
                ),
                //----------Amenities
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: widget.navPosition >= 2
                      ? widget.highlightedBackgroundColor
                      : widget.backgroundColor,
                  child: Icon(
                    Icons.arrow_forward,
                    color: widget.navPosition >= 2
                        ? widget.highlightedIconColor
                        : widget.iconColor,
                    size: 35,
                  ),
                  onPressed: widget.navPosition >= 2
                      ? () {
                          widget.controller.jumpToPage(2);
                        }
                      : null,
                ),
                //----------Location
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: widget.navPosition >= 3
                      ? widget.highlightedBackgroundColor
                      : widget.backgroundColor,
                  child: Icon(
                    Icons.arrow_forward,
                    color: widget.navPosition >= 3
                        ? widget.highlightedIconColor
                        : widget.iconColor,
                    size: 35,
                  ),
                  onPressed: widget.navPosition >= 3
                      ? () {
                          widget.controller.jumpToPage(3);
                        }
                      : null,
                ),
                //----------Comment
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: widget.navPosition >= 4
                      ? widget.highlightedBackgroundColor
                      : widget.backgroundColor,
                  child: Icon(
                    Icons.arrow_forward,
                    color: widget.navPosition >= 4
                        ? widget.highlightedIconColor
                        : widget.iconColor,
                    size: 35,
                  ),
                  onPressed: widget.navPosition >= 4
                      ? () {
                          widget.controller.jumpToPage(4);
                        }
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
