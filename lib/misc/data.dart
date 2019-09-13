import 'package:dgha_brochure/models/languages.dart';
import 'package:dgha_brochure/models/menu_card_data.dart';
import 'package:dgha_brochure/models/menu_tile_data.dart';
import 'package:dgha_brochure/screens/info_screens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Data {
  // -------------------------------------- CARD DATA
  // ------------- GENERAL INFO CARDS
  static final List<MenuCardData> generalInfoCardData = [guideDogCardData, accessCardData];
  static final MenuCardData guideDogCardData = new MenuCardData(
      cardTitle: "Guide Dogs",
      pageToNavigateTo: InfoScreen.id,
      texts: infoLang,
      imagePath: "assets/images/menu_card/info.png",
      pageTitle: "Guide Dogs",
      semanticLabel: "Guide Dogs",
      semanticHint: "Double tap to read more about Guide Dogs");

  static final MenuCardData accessCardData = new MenuCardData(
      cardTitle: "Access",
      pageToNavigateTo: InfoScreen.id,
      texts: accessLang,
      imagePath: "assets/images/menu_card/access.png",
      pageTitle: "Access",
      semanticLabel: "Access",
      semanticHint: "Double Tap to read more about Guide Dogs Access");

  // -------------- LAWS INFO CARDS
  static final List<MenuCardData> lawInfoCardDataABC = [
    actCardData,
    fedCardData,
    nswCardData,
    ntCardData,
    qldCardData,
    saCardData,
    tasCardData,
    vicCardData,
    waCardLaw
  ];

  static final List<MenuCardData> lawInfoCardDataPop = [
    fedCardData,
    nswCardData,
    vicCardData,
    qldCardData,
    waCardLaw,
    saCardData,
    tasCardData,
    actCardData,
    ntCardData,
  ];

  static final MenuCardData fedCardData = new MenuCardData(
      cardTitle: "Federal",
      pageToNavigateTo: InfoScreen.id,
      texts: fedLang,
      imagePath: "assets/images/menu_card/federal.png",
      pageTitle: "Federal",
      semanticLabel: "Federal",
      semanticHint: "Double Tap to read more about Federal Law regarding Guide Dogs");

  static final MenuCardData actCardData = new MenuCardData(
      cardTitle: "ACT",
      pageToNavigateTo: InfoScreen.id,
      texts: actLang,
      imagePath: "assets/images/menu_card/act.png",
      pageTitle: "ACT",
      semanticLabel: "Australian Capital Territory",
      semanticHint: "Double Tap to read more about Australian Capital Territory Law regarding Guide Dogs");

  static final MenuCardData nswCardData = new MenuCardData(
      cardTitle: "NSW",
      pageToNavigateTo: InfoScreen.id,
      texts: nswLang,
      imagePath: "assets/images/menu_card/nsw.png",
      pageTitle: "NSW Law",
      semanticLabel: "New South Wales",
      semanticHint: "Double Tap to read more about New South Wales Law regarding Guide Dogs");

  static final MenuCardData ntCardData = new MenuCardData(
      cardTitle: "NT",
      pageToNavigateTo: InfoScreen.id,
      texts: ntLang,
      imagePath: "assets/images/menu_card/nt.png",
      pageTitle: "NT Law",
      semanticLabel: "Northern Territory",
      semanticHint: "Double Tap to read more about Northern Territory Law regarding Guide Dogs");

  static final MenuCardData qldCardData = new MenuCardData(
      cardTitle: "QLD",
      pageToNavigateTo: InfoScreen.id,
      texts: qldLang,
      imagePath: "assets/images/menu_card/qld.png",
      pageTitle: "QLD Law",
      semanticLabel: "Queensland",
      semanticHint: "Double Tap to read more about Queensland Law regarding Guide Dogs");

  static final MenuCardData saCardData = new MenuCardData(
      cardTitle: "SA",
      pageToNavigateTo: InfoScreen.id,
      texts: saLang,
      imagePath: "assets/images/menu_card/sa.png",
      pageTitle: "SA Law",
      semanticLabel: "South Australia",
      semanticHint: "Double Tap to read more about South Australian Law regarding Guide Dogs");

  static final MenuCardData tasCardData = new MenuCardData(
      cardTitle: "TAS",
      pageToNavigateTo: InfoScreen.id,
      texts: tasLang,
      imagePath: "assets/images/menu_card/tas.png",
      pageTitle: "TAS Law",
      semanticLabel: "Tasmania",
      semanticHint: "Double Tap to read more about Tasmanian Law regarding Guide Dogs");

  static final MenuCardData vicCardData = new MenuCardData(
      cardTitle: "VIC",
      pageToNavigateTo: InfoScreen.id,
      texts: vicLang,
      imagePath: "assets/images/menu_card/vic.png",
      pageTitle: "VIC Law",
      semanticLabel: "Victoria",
      semanticHint: "Double Tap to read more about Victorian Law regarding Guide Dogs");

  static final MenuCardData waCardLaw = new MenuCardData(
      cardTitle: "WA",
      pageToNavigateTo: InfoScreen.id,
      texts: waLang,
      imagePath: "assets/images/menu_card/wa.png",
      pageTitle: "WA Law",
      semanticLabel: "Western Australia",
      semanticHint: "Double Tap to read more about Western Australian Law regarding Guide Dogs");

  // ------------------------------------ MENU LIST TILES
  // ---------------- GENERAL INFO TILES
  static final MenuTileData guideDogInfoTileData = new MenuTileData(
      title: "Guide Dogs",
      pageToNavigateTo: InfoScreen.id,
      texts: infoLang,
      icon: FontAwesomeIcons.dog,
      semanticLabel: "Guide Dogs",
      semanticHint: "Double tap to read more about Guide Dogs");

  static final MenuTileData guideDogAccessTileData = new MenuTileData(
      title: "Access",
      pageToNavigateTo: InfoScreen.id,
      texts: accessLang,
      icon: FontAwesomeIcons.unlockAlt,
      semanticLabel: "Access",
      semanticHint: "Double tap to read more about Guide Dogs Access");

  // ---------------- LAW TILES
  static final MenuTileData lawsTilesListData = new MenuTileData(
      title: "Laws",
      pageToNavigateTo: InfoScreen.id,
      texts: fedLang,
      icon: FontAwesomeIcons.gavel,
      children: lawsTileData,
      semanticLabel: "Laws Drop Down",
      semanticHint: "Double tap to open Laws Menu");

  static final List<MenuTileData> lawsTileData = <MenuTileData>[
    fedTileData,
    actTileData,
    nswTileData,
    ntTileData,
    qldTileData,
    saTileData,
    saTileData,
    tasTileData,
    vicTileData,
    waTileData
  ];

  static final MenuTileData fedTileData = new MenuTileData(
      title: "Federal Law",
      pageToNavigateTo: InfoScreen.id,
      texts: fedLang,
      semanticLabel: "Federal Law",
      semanticHint: "Double Tap to read more about Federal Law regarding Guide Dogs");

  static final MenuTileData actTileData = new MenuTileData(
      title: "ACT Law",
      pageToNavigateTo: InfoScreen.id,
      texts: actLang,
      semanticLabel: "Australian Capital Territory Law",
      semanticHint: "Double Tap to read more about Australian Capital Territory Law regarding Guide Dogs");

  static final MenuTileData nswTileData = new MenuTileData(
      title: "NSW Law",
      pageToNavigateTo: InfoScreen.id,
      texts: nswLang,
      semanticLabel: "New South Wales Law",
      semanticHint: "Double Tap to read more about New South Wales Law regarding Guide Dogs");

  static final MenuTileData ntTileData = new MenuTileData(
      title: "NT Law",
      pageToNavigateTo: InfoScreen.id,
      texts: ntLang,
      semanticLabel: "Northern Territory Law",
      semanticHint: "Double Tap to read more about Northern Territory Law regarding Guide Dogs");

  static final MenuTileData qldTileData = new MenuTileData(
      title: "QLD Law",
      pageToNavigateTo: InfoScreen.id,
      texts: qldLang,
      semanticLabel: "Queensland Law",
      semanticHint: "Double Tap to read more about Queensland Law regarding Guide Dogs");

  static final MenuTileData saTileData = new MenuTileData(
      title: "SA Law",
      pageToNavigateTo: InfoScreen.id,
      texts: saLang,
      semanticLabel: "South Australian Law",
      semanticHint: "Double Tap to read more about South Australian Law regarding Guide Dogs");

  static final MenuTileData tasTileData = new MenuTileData(
      title: "TAS Law",
      pageToNavigateTo: InfoScreen.id,
      texts: tasLang,
      semanticLabel: "Tasmanian Law",
      semanticHint: "Double Tap to read more about Tasmanian Law regarding Guide Dogs");

  static final MenuTileData vicTileData = new MenuTileData(
      title: "VIC Law",
      pageToNavigateTo: InfoScreen.id,
      texts: vicLang,
      semanticLabel: "Victorian Law",
      semanticHint: "Double Tap to read more about Victorian Law regarding Guide Dogs");

  static final MenuTileData waTileData = new MenuTileData(
      title: "WA Law",
      pageToNavigateTo: InfoScreen.id,
      texts: waLang,
      semanticLabel: "Western Australia Law",
      semanticHint: "Double Tap to read more about Western Australian Law regarding Guide Dogs");

  static final MenuTileData signUpTileData = new MenuTileData(
      title: "Sign Up",
      icon: FontAwesomeIcons.solidUser,
      link: "http://dgha.org.au/dgha/membership/",
      semanticLabel: "Sign Up",
      semanticHint: "Double tap to go to the Guide Dog Handlder Australia Sign Up page");

  static final MenuTileData donateTileData = new MenuTileData(
      title: "Donation",
      icon: FontAwesomeIcons.handHoldingUsd,
      link: "http://dgha.org.au/dgha/membership/",
      semanticLabel: "Donation",
      semanticHint: "Double tap to go to the Guide Dog Handler Australia Donation page");

  // ---------------------------------------- LANGUAGES
  // ---------------------- GENERAL INFO LANGUAGES
  static final List<Language> infoLang = <Language>[
    Language(languageName: "English", path: "assets/languages/guide_dog_info/english.txt"),
    Language(languageName: "Arabic", path: "assets/languages/guide_dog_info/arabic.txt"),
    Language(languageName: "Chinese (simplified)", path: "assets/languages/guide_dog_info/chinese(simplified).txt"),
    Language(languageName: "Chinese (traditional)", path: "assets/languages/guide_dog_info/chinese(traditional).txt"),
    Language(languageName: "Greek", path: "assets/languages/guide_dog_info/greek.txt"),
    Language(languageName: "Italian", path: "assets/languages/guide_dog_info/italian.txt"),
    Language(languageName: "Japanese", path: "assets/languages/guide_dog_info/japanese.txt"),
    Language(languageName: "Korean", path: "assets/languages/guide_dog_info/korean.txt"),
    Language(languageName: "Thai", path: "assets/languages/guide_dog_info/thai.txt"),
    Language(languageName: "Vietnamese", path: "assets/languages/guide_dog_info/vietnamese.txt"),
  ];

  static final List<Language> accessLang = <Language>[
    Language(languageName: "English", path: "assets/languages/guide_dog_access/english.txt"),
    Language(languageName: "Arabic", path: "assets/languages/guide_dog_access/arabic.txt"),
    Language(languageName: "Chinese (simplified)", path: "assets/languages/guide_dog_access/chinese(simplified).txt"),
    Language(languageName: "Chinese (traditional)", path: "assets/languages/guide_dog_access/chinese(traditional).txt"),
    Language(languageName: "Greek", path: "assets/languages/guide_dog_access/greek.txt"),
    Language(languageName: "Italian", path: "assets/languages/guide_dog_access/italian.txt"),
    Language(languageName: "Japanese", path: "assets/languages/guide_dog_access/japanese.txt"),
    Language(languageName: "Korean", path: "assets/languages/guide_dog_access/korean.txt"),
    Language(languageName: "Thai", path: "assets/languages/guide_dog_access/thai.txt"),
    Language(languageName: "Vietnamese", path: "assets/languages/guide_dog_access/vietnamese.txt"),
  ];

  // ----------------------- LAWS INFO LANGUAGES
  static final List<Language> fedLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/federal/english.txt"),
    Language(languageName: "Arabic", path: "assets/languages/laws/federal/arabic.txt"),
    Language(languageName: "Chinese (simplified)", path: "assets/languages/laws/federal/chinese(simplified).txt"),
    Language(languageName: "Chinese (traditional)", path: "assets/languages/laws/federal/chinese(traditional).txt"),
    Language(languageName: "Greek", path: "assets/languages/laws/federal/greek.txt"),
    Language(languageName: "Italian", path: "assets/languages/laws/federal/italian.txt"),
    Language(languageName: "Japanese", path: "assets/languages/laws/federal/japanese.txt"),
    Language(languageName: "Korean", path: "assets/languages/laws/federal/korean.txt"),
    Language(languageName: "Thai", path: "assets/languages/laws/federal/thai.txt"),
    Language(languageName: "Vietnamese", path: "assets/languages/laws/federal/vietnamese.txt"),
  ];

  static final List<Language> actLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/act/english.txt"),
    Language(languageName: "Arabic", path: "assets/languages/laws/act/arabic.txt"),
    Language(languageName: "Chinese (simplified)", path: "assets/languages/laws/act/chinese(simplified).txt"),
    Language(languageName: "Chinese (traditional)", path: "assets/languages/laws/act/chinese(traditional).txt"),
    Language(languageName: "Greek", path: "assets/languages/laws/act/greek.txt"),
    Language(languageName: "Italian", path: "assets/languages/laws/act/italian.txt"),
    Language(languageName: "Japanese", path: "assets/languages/laws/act/japanese.txt"),
    Language(languageName: "Korean", path: "assets/languages/laws/act/korean.txt"),
    Language(languageName: "Thai", path: "assets/languages/laws/act/thai.txt"),
    Language(languageName: "Vietnamese", path: "assets/languages/laws/act/vietnamese.txt"),
  ];

  static final List<Language> nswLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/nsw/english.txt"),
    Language(languageName: "Arabic", path: "assets/languages/laws/nsw/arabic.txt"),
    Language(languageName: "Chinese (simplified)", path: "assets/languages/laws/nsw/chinese(simplified).txt"),
    Language(languageName: "Chinese (traditional)", path: "assets/languages/laws/nsw/chinese(traditional).txt"),
    Language(languageName: "Greek", path: "assets/languages/laws/nsw/greek.txt"),
    Language(languageName: "Italian", path: "assets/languages/laws/nsw/italian.txt"),
    Language(languageName: "Japanese", path: "assets/languages/laws/nsw/japanese.txt"),
    Language(languageName: "Korean", path: "assets/languages/laws/nsw/korean.txt"),
    Language(languageName: "Thai", path: "assets/languages/laws/nsw/thai.txt"),
    Language(languageName: "Vietnamese", path: "assets/languages/laws/nsw/vietnamese.txt"),
  ];

  static final List<Language> ntLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/nt/english.txt"),
    Language(languageName: "Arabic", path: "assets/languages/laws/nt/arabic.txt"),
    Language(languageName: "Chinese (simplified)", path: "assets/languages/laws/nt/chinese(simplified).txt"),
    Language(languageName: "Chinese (traditional)", path: "assets/languages/laws/nt/chinese(traditional).txt"),
    Language(languageName: "Greek", path: "assets/languages/laws/nt/greek.txt"),
    Language(languageName: "Italian", path: "assets/languages/laws/nt/italian.txt"),
    Language(languageName: "Japanese", path: "assets/languages/laws/nt/japanese.txt"),
    Language(languageName: "Korean", path: "assets/languages/laws/nt/korean.txt"),
    Language(languageName: "Thai", path: "assets/languages/laws/nt/thai.txt"),
    Language(languageName: "Vietnamese", path: "assets/languages/laws/nt/vietnamese.txt"),
  ];

  static final List<Language> qldLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/qld/english.txt"),
    Language(languageName: "Arabic", path: "assets/languages/laws/qld/arabic.txt"),
    Language(languageName: "Chinese (simplified)", path: "assets/languages/laws/qld/chinese(simplified).txt"),
    Language(languageName: "Chinese (traditional)", path: "assets/languages/laws/qld/chinese(traditional).txt"),
    Language(languageName: "Greek", path: "assets/languages/laws/qld/greek.txt"),
    Language(languageName: "Italian", path: "assets/languages/laws/qld/italian.txt"),
    Language(languageName: "Japanese", path: "assets/languages/laws/qld/japanese.txt"),
    Language(languageName: "Korean", path: "assets/languages/laws/qld/korean.txt"),
    Language(languageName: "Thai", path: "assets/languages/laws/qld/thai.txt"),
    Language(languageName: "Vietnamese", path: "assets/languages/laws/qld/vietnamese.txt"),
  ];

  static final List<Language> saLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/sa/english.txt"),
    Language(languageName: "Arabic", path: "assets/languages/laws/sa/arabic.txt"),
    Language(languageName: "Chinese (simplified)", path: "assets/languages/laws/sa/chinese(simplified).txt"),
    Language(languageName: "Chinese (traditional)", path: "assets/languages/laws/sa/chinese(traditional).txt"),
    Language(languageName: "Greek", path: "assets/languages/laws/sa/greek.txt"),
    Language(languageName: "Italian", path: "assets/languages/laws/sa/italian.txt"),
    Language(languageName: "Japanese", path: "assets/languages/laws/sa/japanese.txt"),
    Language(languageName: "Korean", path: "assets/languages/laws/sa/korean.txt"),
    Language(languageName: "Thai", path: "assets/languages/laws/sa/thai.txt"),
    Language(languageName: "Vietnamese", path: "assets/languages/laws/sa/vietnamese.txt"),
  ];

  static final List<Language> tasLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/tas/english.txt"),
    Language(languageName: "Arabic", path: "assets/languages/laws/tas/arabic.txt"),
    Language(languageName: "Chinese (simplified)", path: "assets/languages/laws/tas/chinese(simplified).txt"),
    Language(languageName: "Chinese (traditional)", path: "assets/languages/laws/tas/chinese(traditional).txt"),
    Language(languageName: "Greek", path: "assets/languages/laws/tas/greek.txt"),
    Language(languageName: "Italian", path: "assets/languages/laws/tas/italian.txt"),
    Language(languageName: "Japanese", path: "assets/languages/laws/tas/japanese.txt"),
    Language(languageName: "Korean", path: "assets/languages/laws/tas/korean.txt"),
    Language(languageName: "Thai", path: "assets/languages/laws/tas/thai.txt"),
    Language(languageName: "Vietnamese", path: "assets/languages/laws/tas/vietnamese.txt"),
  ];

  static final List<Language> vicLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/vic/english.txt"),
    Language(languageName: "Arabic", path: "assets/languages/laws/vic/arabic.txt"),
    Language(languageName: "Chinese (simplified)", path: "assets/languages/laws/vic/chinese(simplified).txt"),
    Language(languageName: "Chinese (traditional)", path: "assets/languages/laws/vic/chinese(traditional).txt"),
    Language(languageName: "Greek", path: "assets/languages/laws/vic/greek.txt"),
    Language(languageName: "Italian", path: "assets/languages/laws/vic/italian.txt"),
    Language(languageName: "Japanese", path: "assets/languages/laws/vic/japanese.txt"),
    Language(languageName: "Korean", path: "assets/languages/laws/vic/korean.txt"),
    Language(languageName: "Thai", path: "assets/languages/laws/vic/thai.txt"),
    Language(languageName: "Vietnamese", path: "assets/languages/laws/vic/vietnamese.txt"),
  ];

  static final List<Language> waLang = <Language>[
    Language(languageName: "English", path: "assets/languages/laws/wa/english.txt"),
    Language(languageName: "Arabic", path: "assets/languages/laws/wa/arabic.txt"),
    Language(languageName: "Chinese (simplified)", path: "assets/languages/laws/wa/chinese(simplified).txt"),
    Language(languageName: "Chinese (traditional)", path: "assets/languages/laws/wa/chinese(traditional).txt"),
    Language(languageName: "Greek", path: "assets/languages/laws/wa/greek.txt"),
    Language(languageName: "Italian", path: "assets/languages/laws/wa/italian.txt"),
    Language(languageName: "Japanese", path: "assets/languages/laws/wa/japanese.txt"),
    Language(languageName: "Korean", path: "assets/languages/laws/wa/korean.txt"),
    Language(languageName: "Thai", path: "assets/languages/laws/wa/thai.txt"),
    Language(languageName: "Vietnamese", path: "assets/languages/laws/wa/vietnamese.txt"),
  ];
}
