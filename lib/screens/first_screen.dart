import 'package:dgha_brochure/misc/styles.dart';
import 'package:dgha_brochure/screens/explore_screen.dart';
import 'package:dgha_brochure/screens/register_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';

// TODO: pop this screen if it opens the second time

class FirstScreen extends StatefulWidget {
  static const String id = "First Screen";

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    this.initDynamicLink();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.midnightBlue,
    );
  }

  void initDynamicLink() async {
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    // When the app is not yet opened
    if (deepLink != null) {
      Navigator.of(context).pushNamed(RegisterScreen.id);
    } else {
      Navigator.of(context).pushNamed(ExploreScreen.id);
    }

    // When the app is opened
    FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        Navigator.of(context).pushNamed(RegisterScreen.id);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError: ' + e.message);
    });
  }
}
