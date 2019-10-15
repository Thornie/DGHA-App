import 'package:flutter/material.dart';

class RatingBreadcrumbs extends StatefulWidget {
  //How many tabs to color in starting at 0
  final int navPosition;

  final Color iconColor;
  final Color backgroundColor;
  final Color highlightedColor;

  RatingBreadcrumbs(
      {this.navPosition,
      this.backgroundColor,
      this.iconColor,
      this.highlightedColor});
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
                GestureDetector(
                  child: Container(
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.arrow_forward,
                      color: widget.iconColor,
                      size: 35,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.navPosition >= 0
                          ? widget.highlightedColor
                          : widget.backgroundColor,
                    ),
                  ),
                  onTap: () {
                    print("TE");
                  },
                ),
                //----------Customer Service
                Container(
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.arrow_forward,
                    color: widget.iconColor,
                    size: 35,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.navPosition >= 1
                        ? widget.highlightedColor
                        : widget.backgroundColor,
                  ),
                ),
                //----------Amenities
                Container(
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.arrow_forward,
                    color: widget.iconColor,
                    size: 35,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.navPosition >= 2
                        ? widget.highlightedColor
                        : widget.backgroundColor,
                  ),
                ),
                //----------Location
                Container(
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.arrow_forward,
                    color: widget.iconColor,
                    size: 35,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.navPosition >= 3
                        ? widget.highlightedColor
                        : widget.backgroundColor,
                  ),
                ),
                //----------Comment
                Container(
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.arrow_forward,
                    color: widget.iconColor,
                    size: 35,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.navPosition >= 4
                        ? widget.highlightedColor
                        : widget.backgroundColor,
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
