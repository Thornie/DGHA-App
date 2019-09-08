import 'package:dgha_brochure/models/languages.dart';
import 'package:dgha_brochure/models/menu_card_data.dart';
import 'package:dgha_brochure/models/menu_tile_data.dart';
import 'package:dgha_brochure/screens/info_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Data {
  // -------------------------------------- NOTE: Card Data
  static final List<MenuCardData> generalInfoCardData = [infoCardData, accessCardData];

  static final List<MenuCardData> lawInfoCardData = [
    fedCardData,
    actCardData,
    nswCardData,
    ntCardData,
    qldCardData,
    saCardData,
    tasCardData,
    vicCardData,
    waCardLaw
  ];

  static final List<MenuCardData> lawInfoCardDataLandRow1 = [fedCardData, actCardData, nswCardData, ntCardData];
  static final List<MenuCardData> lawInfoCardDataLandRow2 = [qldCardData, saCardData, tasCardData, vicCardData];
  static final List<MenuCardData> lawInfoCardDataLandRow3 = [waCardLaw];

  static final List<MenuCardData> lawInfoCardDataPortRow1 = [fedCardData, actCardData];
  static final List<MenuCardData> lawInfoCardDataPortRow2 = [nswCardData, ntCardData];
  static final List<MenuCardData> lawInfoCardDataPortRow3 = [qldCardData, saCardData];
  static final List<MenuCardData> lawInfoCardDataPortRow4 = [tasCardData, vicCardData];
  static final List<MenuCardData> lawInfoCardDataPortRow5 = [waCardLaw];

  static final MenuCardData infoCardData = new MenuCardData(
    shortTitle: "Guide Dog",
    pageToNavigateTo: InfoScreen.id,
    texts: infoLang,
    imagePath: "assets/images/menu_card/info.png",
    pageTitle: "Guide Dog Info",
  );

  static final MenuCardData accessCardData = new MenuCardData(
    shortTitle: "Access",
    pageToNavigateTo: InfoScreen.id,
    texts: accessLang,
    imagePath: "assets/images/menu_card/access.png",
    pageTitle: "Access",
  );

  static final MenuCardData fedCardData = new MenuCardData(
    shortTitle: "Federal",
    pageToNavigateTo: InfoScreen.id,
    texts: fedLang,
    imagePath: "",
    pageTitle: "Federal Law",
  );

  static final MenuCardData actCardData = new MenuCardData(
    shortTitle: "ACT",
    pageToNavigateTo: InfoScreen.id,
    texts: actLang,
    imagePath: "",
    pageTitle: "ACT State Law",
  );

  static final MenuCardData nswCardData = new MenuCardData(
    shortTitle: "NSW",
    pageToNavigateTo: InfoScreen.id,
    texts: nswLang,
    imagePath: "",
    pageTitle: "NSW State Law",
  );

  static final MenuCardData ntCardData = new MenuCardData(
    shortTitle: "NT",
    pageToNavigateTo: InfoScreen.id,
    texts: ntLang,
    imagePath: "",
    pageTitle: "NT State Law",
  );

  static final MenuCardData qldCardData = new MenuCardData(
    shortTitle: "QLD",
    pageToNavigateTo: InfoScreen.id,
    texts: qldLang,
    imagePath: "",
    pageTitle: "QLD State Law",
  );

  static final MenuCardData saCardData = new MenuCardData(
    shortTitle: "SA",
    pageToNavigateTo: InfoScreen.id,
    texts: saLang,
    imagePath: "",
    pageTitle: "SA State Law",
  );

  static final MenuCardData tasCardData = new MenuCardData(
    shortTitle: "TAS",
    pageToNavigateTo: InfoScreen.id,
    texts: tasLang,
    imagePath: "",
    pageTitle: "TAS State Law",
  );

  static final MenuCardData vicCardData = new MenuCardData(
    shortTitle: "VIC",
    pageToNavigateTo: InfoScreen.id,
    texts: vicLang,
    imagePath: "",
    pageTitle: "VIC State Law",
  );

  static final MenuCardData waCardLaw = new MenuCardData(
    shortTitle: "WA",
    pageToNavigateTo: InfoScreen.id,
    texts: waLang,
    imagePath: "",
    pageTitle: "WA State Law",
  );

  // ------------------------------------ NOTE: Menu List Tiles
  static final MenuTileData guideDogInfoTileData =
      new MenuTileData(title: "Guide Dog", pageToNavigateTo: InfoScreen.id, texts: infoLang, icon: FontAwesomeIcons.dog);
  static final MenuTileData guideDogAccessTileData =
      new MenuTileData(title: "Access", pageToNavigateTo: InfoScreen.id, texts: accessLang, icon: FontAwesomeIcons.unlockAlt);
  static final MenuTileData fedTileData =
      new MenuTileData(title: "Laws", pageToNavigateTo: InfoScreen.id, texts: fedLang, icon: FontAwesomeIcons.gavel, children: stateLawTilesData);
  static final MenuTileData signUpTileData =
      new MenuTileData(title: "Sign Up", icon: FontAwesomeIcons.solidUser, link: "http://dgha.org.au/dgha/membership/");
  static final MenuTileData donateTileData =
      new MenuTileData(title: "Donation", icon: FontAwesomeIcons.handHoldingUsd, link: "http://dgha.org.au/dgha/membership/");

  static final List<MenuTileData> stateLawTilesData = <MenuTileData>[
    MenuTileData(title: "Federal Law", pageToNavigateTo: InfoScreen.id, texts: fedLang),
    MenuTileData(title: "ACT State Law", pageToNavigateTo: InfoScreen.id, texts: actLang),
    MenuTileData(title: "NSW State Law", pageToNavigateTo: InfoScreen.id, texts: nswLang),
    MenuTileData(title: "NT State Law", pageToNavigateTo: InfoScreen.id, texts: ntLang),
    MenuTileData(title: "QLD State Law", pageToNavigateTo: InfoScreen.id, texts: qldLang),
    MenuTileData(title: "SA State Law", pageToNavigateTo: InfoScreen.id, texts: saLang),
    MenuTileData(title: "TAS State Law", pageToNavigateTo: InfoScreen.id, texts: tasLang),
    MenuTileData(title: "VIC State Law", pageToNavigateTo: InfoScreen.id, texts: vicLang),
    MenuTileData(title: "WA State Law", pageToNavigateTo: InfoScreen.id, texts: waLang),
  ];

  // ---------------------------- NOTE: Languages

  static final List<Language> infoLang = <Language>[
    Language(languageName: "English", path: "assets/languages/guide_dog_info/english.txt"),
    Language(languageName: "French", path: "assets/languages/guide_dog_info/french.txt"),
    Language(languageName: "Spanish", path: "assets/languages/guide_dog_info/spanish.txt"),
    Language(languageName: "Swahilli", path: "assets/languages/guide_dog_info/swahilli.txt"),
    Language(languageName: "Tagalog", path: "assets/languages/guide_dog_info/tagalog.txt"),
  ];

  static final List<Language> accessLang = <Language>[
    Language(languageName: "English", path: "assets/languages/guide_dog_access/english.txt"),
    Language(languageName: "French", path: "assets/languages/guide_dog_access/french.txt"),
    Language(languageName: "Spanish", path: "assets/languages/guide_dog_access/spanish.txt"),
    Language(languageName: "Swahilli", path: "assets/languages/guide_dog_access/swahilli.txt"),
    Language(languageName: "Tagalog", path: "assets/languages/guide_dog_access/tagalog.txt"),
  ];

  static final List<Language> fedLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/federal/english.txt"),
    Language(languageName: "French", path: "assets/languages/laws/federal/french.txt"),
    Language(languageName: "Spanish", path: "assets/languages/laws/federal/spanish.txt"),
    Language(languageName: "Swahilli", path: "assets/languages/laws/federal/swahilli.txt"),
    Language(languageName: "Tagalog", path: "assets/languages/laws/federal/tagalog.txt"),
  ];

  static final List<Language> actLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/act/english.txt"),
    Language(languageName: "French", path: "assets/languages/laws/act/french.txt"),
    Language(languageName: "Spanish", path: "assets/languages/laws/act/spanish.txt"),
    Language(languageName: "Swahilli", path: "assets/languages/laws/act/swahilli.txt"),
    Language(languageName: "Tagalog", path: "assets/languages/laws/act/tagalog.txt"),
  ];

  static final List<Language> nswLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/nsw/english.txt"),
    Language(languageName: "French", path: "assets/languages/laws/nsw/french.txt"),
    Language(languageName: "Spanish", path: "assets/languages/laws/nsw/spanish.txt"),
    Language(languageName: "Swahilli", path: "assets/languages/laws/nsw/swahilli.txt"),
    Language(languageName: "Tagalog", path: "assets/languages/laws/nsw/tagalog.txt"),
  ];

  static final List<Language> ntLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/nt/english.txt"),
    Language(languageName: "French", path: "assets/languages/laws/nt/french.txt"),
    Language(languageName: "Spanish", path: "assets/languages/laws/nt/spanish.txt"),
    Language(languageName: "Swahilli", path: "assets/languages/laws/nt/swahilli.txt"),
    Language(languageName: "Tagalog", path: "assets/languages/laws/nt/tagalog.txt"),
  ];

  static final List<Language> qldLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/qld/english.txt"),
    Language(languageName: "French", path: "assets/languages/laws/qld/french.txt"),
    Language(languageName: "Spanish", path: "assets/languages/laws/qld/spanish.txt"),
    Language(languageName: "Swahilli", path: "assets/languages/laws/qld/swahilli.txt"),
    Language(languageName: "Tagalog", path: "assets/languages/laws/qld/tagalog.txt"),
  ];

  static final List<Language> saLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/sa/english.txt"),
    Language(languageName: "French", path: "assets/languages/laws/sa/french.txt"),
    Language(languageName: "Spanish", path: "assets/languages/laws/sa/spanish.txt"),
    Language(languageName: "Swahilli", path: "assets/languages/laws/sa/swahilli.txt"),
    Language(languageName: "Tagalog", path: "assets/languages/laws/sa/tagalog.txt"),
  ];

  static final List<Language> tasLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/tas/english.txt"),
    Language(languageName: "French", path: "assets/languages/laws/tas/french.txt"),
    Language(languageName: "Spanish", path: "assets/languages/laws/tas/spanish.txt"),
    Language(languageName: "Swahilli", path: "assets/languages/laws/tas/swahilli.txt"),
    Language(languageName: "Tagalog", path: "assets/languages/laws/tas/tagalog.txt"),
  ];

  static final List<Language> vicLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/vic/english.txt"),
    Language(languageName: "French", path: "assets/languages/laws/vic/french.txt"),
    Language(languageName: "Spanish", path: "assets/languages/laws/vic/spanish.txt"),
    Language(languageName: "Swahilli", path: "assets/languages/laws/vic/swahilli.txt"),
    Language(languageName: "Tagalog", path: "assets/languages/laws/vic/tagalog.txt"),
  ];

  static final List<Language> waLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/wa/english.txt"),
    Language(languageName: "French", path: "assets/languages/laws/wa/french.txt"),
    Language(languageName: "Spanish", path: "assets/languages/laws/wa/spanish.txt"),
    Language(languageName: "Swahilli", path: "assets/languages/laws/wa/swahilli.txt"),
    Language(languageName: "Tagalog", path: "assets/languages/laws/wa/tagalog.txt"),
  ];

  // ----------------------------------- NOTE: Images
  static final String logo = "assets/images/dgha_logo/logo.png";
  static final String infoMenuImg = "assets/images/menu_card/info.png";
  static final String accessMenuImg = "assets/images/menu_card/access.png";
}
