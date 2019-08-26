import 'package:flutter/material.dart';
import 'package:dgha_brochure/component/infoContainer.dart';

class DGInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new InfoContainer(
      title: "About Guide Dogs",
      paragraphText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      titleColour: Colors.black,
      paragraphTextColour: Colors.black,
      containerColour: Color(0xfffef1d8),
      paragraphContainerColour: Colors.white, 
      paragraphContainerShadowColour: Color(0xffcf9611),);
  }
}


