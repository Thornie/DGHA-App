import 'package:flutter/material.dart';
import 'package:dgha_brochure/global.dart';
import '../law_screens/federal_law_screen.dart';
import '../law_screens/act_law_screen.dart';
import '../law_screens/nsw_law_screen.dart';
import '../law_screens/nt_law_screen.dart';
import '../law_screens/qld_law_screen.dart';
import '../law_screens/sa_law_screen.dart';
import '../law_screens/tas_law_screen.dart';
import '../law_screens/vic_law_screen.dart';
import '../law_screens/wa_law_screen.dart';

class LawScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: PageController(initialPage: Global.verticalPageIndex, keepPage: false),
      onPageChanged: (index) {
        Global.verticalPageIndex = index; 
      },
      scrollDirection: Axis.vertical,
      children: <Widget>[
        FedLawScreen(),
        ActLawScreen(),
        NSWLawScreen(),
        NTLawScreen(),
        QLDLawScreen(),
        SALawScreen(),
        TASLawScreen(),
        VICLawScreen(),
        WALawScreen(),        
      ],
    );
  }
}