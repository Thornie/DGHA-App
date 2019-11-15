import 'package:dgha/screens/register_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class OpenDynamicLink {
  static void initDynamicLink(BuildContext context) async {
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    // When the app is not yet opened
    if (deepLink != null) {
      Navigator.of(context).pushNamed(RegisterScreen.id);
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
