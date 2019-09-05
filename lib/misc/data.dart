import 'package:dgha_brochure/models/languages.dart';
import 'package:dgha_brochure/models/menu_card_data.dart';
import 'package:dgha_brochure/models/menu_tile_data.dart';
import 'package:dgha_brochure/screens/info_screens.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Data {

  // -------------------------------------- NOTE: Card Data
  static final List<MenuCardData> generalInfoCardData = <MenuCardData>[
    MenuCardData(
        title: "Guide Dog",
        pageToNavigateTo: InfoScreen.id,
        texts: infoLang,
        colour: Colors.pink,
        pageTitle: "Guide Dog Info"),
    MenuCardData(
        title: "Access",
        pageToNavigateTo: InfoScreen.id,
        texts: accessLang,
        colour: Colors.amber,
        pageTitle: "Guide Dog Access"),
  ];

  static final List<MenuCardData> lawInfoCardData = <MenuCardData>[
    MenuCardData(
        title: "Federal",
        pageToNavigateTo: InfoScreen.id,
        texts: fedLang,
        colour: Colors.pink,
        pageTitle: "Federal Law"),
    MenuCardData(
        title: "ACT",
        pageToNavigateTo: InfoScreen.id,
        texts: actLang,
        colour: Colors.pink,
        pageTitle: "ACT State Law"),
    MenuCardData(
        title: "NSW",
        pageToNavigateTo: InfoScreen.id,
        texts: nswLang,
        colour: Colors.pink,
        pageTitle: "NSW State Law"),
    MenuCardData(
        title: "NT",
        pageToNavigateTo: InfoScreen.id,
        texts: ntLang,
        colour: Colors.pink,
        pageTitle: "NT State Law"),
    MenuCardData(
        title: "QLD",
        pageToNavigateTo: InfoScreen.id,
        texts: qldLang,
        colour: Colors.pink,
        pageTitle: "QLD State Law"),
    MenuCardData(
        title: "SA",
        pageToNavigateTo: InfoScreen.id,
        texts: saLang,
        colour: Colors.pink,
        pageTitle: "SA State Law"),
    MenuCardData(
        title: "TAS",
        pageToNavigateTo: InfoScreen.id,
        texts: tasLang,
        colour: Colors.pink,
        pageTitle: "TAS State Law"),
    MenuCardData(
        title: "VIC",
        pageToNavigateTo: InfoScreen.id,
        texts: vicLang,
        colour: Colors.pink,
        pageTitle: "VIC State Law"),
    MenuCardData(
        title: "WA",
        pageToNavigateTo: InfoScreen.id,
        texts: waLang,
        colour: Colors.pink,
        pageTitle: "WA State Law"),
  ];

  // ------------------------------------ NOTE: Menu List Tiles
  static final MenuTileData guideDogInfoTileData = new MenuTileData(
      title: "Guide Dog Info",
      pageToNavigateTo: InfoScreen.id,
      texts: infoLang,
      icon: FontAwesomeIcons.dog);
  static final MenuTileData guideDogAccessTileData = new MenuTileData(
      title: "Guide Dog Access",
      pageToNavigateTo: InfoScreen.id,
      texts: accessLang,
      icon: FontAwesomeIcons.unlockAlt);
  static final MenuTileData fedTileData = new MenuTileData(
      title: "Laws",
      pageToNavigateTo: InfoScreen.id,
      texts: fedLang,
      icon: FontAwesomeIcons.gavel,
      children: stateLawTilesData);
  static final MenuTileData signUpTileData = new MenuTileData(
      title: "Sign Up Membership",
      icon: FontAwesomeIcons.userPlus,
      link: "http://dgha.org.au/dgha/membership/");
  static final MenuTileData donateTileData = new MenuTileData(
      title: "Donation",
      icon: FontAwesomeIcons.donate,
      link: "http://dgha.org.au/dgha/membership/");

  static final List<MenuTileData> stateLawTilesData = <MenuTileData>[
    MenuTileData(
        title: "Federal Law", pageToNavigateTo: InfoScreen.id, texts: fedLang),
    MenuTileData(
        title: "ACT State Law",
        pageToNavigateTo: InfoScreen.id,
        texts: actLang),
    MenuTileData(
        title: "NSW State Law",
        pageToNavigateTo: InfoScreen.id,
        texts: nswLang),
    MenuTileData(
        title: "NT State Law", pageToNavigateTo: InfoScreen.id, texts: ntLang),
    MenuTileData(
        title: "QLD State Law",
        pageToNavigateTo: InfoScreen.id,
        texts: qldLang),
    MenuTileData(
        title: "SA State Law", pageToNavigateTo: InfoScreen.id, texts: saLang),
    MenuTileData(
        title: "TAS State Law",
        pageToNavigateTo: InfoScreen.id,
        texts: tasLang),
    MenuTileData(
        title: "VIC State Law",
        pageToNavigateTo: InfoScreen.id,
        texts: vicLang),
    MenuTileData(
        title: "WA State Law", pageToNavigateTo: InfoScreen.id, texts: waLang),
  ];

  // ---------------------------- NOTE: Languages

  static final List<Language> infoLang = <Language>[
    Language(
        languageName: "English", path: "languages/guide_dog_info/english.txt"),
    Language(
        languageName: "French", path: "languages/guide_dog_info/french.txt"),
    Language(
        languageName: "Spanish", path: "languages/guide_dog_info/spanish.txt"),
    Language(
        languageName: "Swahilli",
        path: "languages/guide_dog_info/swahilli.txt"),
    Language(
        languageName: "Tagalog", path: "languages/guide_dog_info/tagalog.txt"),
  ];

  static final List<Language> accessLang = <Language>[
    Language(
        languageName: "English",
        path: "languages/guide_dog_access/english.txt"),
    Language(
        languageName: "French", path: "languages/guide_dog_access/french.txt"),
    Language(
        languageName: "Spanish",
        path: "languages/guide_dog_access/spanish.txt"),
    Language(
        languageName: "Swahilli",
        path: "languages/guide_dog_access/swahilli.txt"),
    Language(
        languageName: "Tagalog",
        path: "languages/guide_dog_access/tagalog.txt"),
  ];

  static final List<Language> fedLang = <Language>[
    Language(
        languageName: "English", path: "languages/laws/federal/english.txt"),
    Language(languageName: "French", path: "languages/laws/federal/french.txt"),
    Language(
        languageName: "Spanish", path: "languages/laws/federal/spanish.txt"),
    Language(
        languageName: "Swahilli", path: "languages/laws/federal/swahilli.txt"),
    Language(
        languageName: "Tagalog", path: "languages/laws/federal/tagalog.txt"),
  ];

  static final List<Language> actLang = <Language>[
    Language(languageName: "English", path: "languages/laws/act/english.txt"),
    Language(languageName: "French", path: "languages/laws/act/french.txt"),
    Language(languageName: "Spanish", path: "languages/laws/act/spanish.txt"),
    Language(languageName: "Swahilli", path: "languages/laws/act/swahilli.txt"),
    Language(languageName: "Tagalog", path: "languages/laws/act/tagalog.txt"),
  ];

  static final List<Language> nswLang = <Language>[
    Language(languageName: "English", path: "languages/laws/nsw/english.txt"),
    Language(languageName: "French", path: "languages/laws/nsw/french.txt"),
    Language(languageName: "Spanish", path: "languages/laws/nsw/spanish.txt"),
    Language(languageName: "Swahilli", path: "languages/laws/nsw/swahilli.txt"),
    Language(languageName: "Tagalog", path: "languages/laws/nsw/tagalog.txt"),
  ];

  static final List<Language> ntLang = <Language>[
    Language(languageName: "English", path: "languages/laws/nt/english.txt"),
    Language(languageName: "French", path: "languages/laws/nt/french.txt"),
    Language(languageName: "Spanish", path: "languages/laws/nt/spanish.txt"),
    Language(languageName: "Swahilli", path: "languages/laws/nt/swahilli.txt"),
    Language(languageName: "Tagalog", path: "languages/laws/nt/tagalog.txt"),
  ];

  static final List<Language> qldLang = <Language>[
    Language(languageName: "English", path: "languages/laws/qld/english.txt"),
    Language(languageName: "French", path: "languages/laws/qld/french.txt"),
    Language(languageName: "Spanish", path: "languages/laws/qld/spanish.txt"),
    Language(languageName: "Swahilli", path: "languages/laws/qld/swahilli.txt"),
    Language(languageName: "Tagalog", path: "languages/laws/qld/tagalog.txt"),
  ];

  static final List<Language> saLang = <Language>[
    Language(languageName: "English", path: "languages/laws/sa/english.txt"),
    Language(languageName: "French", path: "languages/laws/sa/french.txt"),
    Language(languageName: "Spanish", path: "languages/laws/sa/spanish.txt"),
    Language(languageName: "Swahilli", path: "languages/laws/sa/swahilli.txt"),
    Language(languageName: "Tagalog", path: "languages/laws/sa/tagalog.txt"),
  ];

  static final List<Language> tasLang = <Language>[
    Language(languageName: "English", path: "languages/laws/tas/english.txt"),
    Language(languageName: "French", path: "languages/laws/tas/french.txt"),
    Language(languageName: "Spanish", path: "languages/laws/tas/spanish.txt"),
    Language(languageName: "Swahilli", path: "languages/laws/tas/swahilli.txt"),
    Language(languageName: "Tagalog", path: "languages/laws/tas/tagalog.txt"),
  ];

  static final List<Language> vicLang = <Language>[
    Language(languageName: "English", path: "languages/laws/vic/english.txt"),
    Language(languageName: "French", path: "languages/laws/vic/french.txt"),
    Language(languageName: "Spanish", path: "languages/laws/vic/spanish.txt"),
    Language(languageName: "Swahilli", path: "languages/laws/vic/swahilli.txt"),
    Language(languageName: "Tagalog", path: "languages/laws/vic/tagalog.txt"),
  ];

  static final List<Language> waLang = <Language>[
    Language(languageName: "English", path: "languages/laws/wa/english.txt"),
    Language(languageName: "French", path: "languages/laws/wa/french.txt"),
    Language(languageName: "Spanish", path: "languages/laws/wa/spanish.txt"),
    Language(languageName: "Swahilli", path: "languages/laws/wa/swahilli.txt"),
    Language(languageName: "Tagalog", path: "languages/laws/wa/tagalog.txt"),
  ];
}
