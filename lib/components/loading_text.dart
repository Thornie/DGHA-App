import 'package:dgha/misc/styles.dart';
import 'package:flutter/material.dart';

class LoadingText extends StatelessWidget {
  final bool condition;
  LoadingText({@required this.condition});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (this.condition) {
          return Center(
            child: Container(
              child: Text(
                "Loading . . .",
                style: Styles.h1Style,
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
