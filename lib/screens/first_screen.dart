import 'package:dgha_brochure/screens/register_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

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
      child: Text("OOOOOOOO"),
    );
  }

  void initDynamicLink() async {
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      print("what is going on");
      Navigator.pushNamed(context, RegisterScreen.id);
    } else {
      print("ummm");
    }

    FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        Navigator.pushNamed(context, RegisterScreen.id);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError: ' + e.message);
    });
  }
}
