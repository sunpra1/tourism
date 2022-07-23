import 'package:flutter/material.dart';

class Menu {
  final MenuType menuType;
  final IconData? icon;

  Menu({required this.menuType, required this.icon});
}

enum MenuType {
  home,
  blog,
  images,
  videos,
  aboutUs,
  privacyPolicy,
  termsAndCondition,
  map,
  nearMe,
  whereToStay,
  essentials,
  createStory,
  places,
  askAQuery,
  restrooms,
  audioGuide,
  panchpokhariAtGlance,
  destinations,
  eBrochure,
  travelDesk,
  smartAssist,
  tourPackages,
  myTrips,
  nearBy,
  socialChannels,
  settings
}

extension MenuTypeExt on MenuType {
  String get value {
    String value;
    switch (this) {
      case MenuType.home:
        value = "HOME";
        break;
      case MenuType.blog:
        value = "BLOG";
        break;
      case MenuType.images:
        value = "IMAGES";
        break;
      case MenuType.videos:
        value = "VIDEOS";
        break;
      case MenuType.aboutUs:
        value = "ABOUT PANCHPOKHARI";
        break;
      case MenuType.privacyPolicy:
        value = "PRIVACY POLICY";
        break;
      case MenuType.termsAndCondition:
        value = "TERMS & CONDITION";
        break;
      case MenuType.map:
        value = "MAP";
        break;
      case MenuType.nearMe:
        value = "Near Me";
        break;
      case MenuType.whereToStay:
        value = "Where to Stay";
        break;
      case MenuType.places:
        value = "Places";
        break;
      case MenuType.askAQuery:
        value = "Ask a Query";
        break;
      case MenuType.restrooms:
        value = "Restrooms";
        break;
      case MenuType.audioGuide:
        value = "Audio Guide";
        break;
      case MenuType.essentials:
        value = "Essentials";
        break;
      case MenuType.createStory:
        value = "Create Story";
        break;
      case MenuType.panchpokhariAtGlance:
        value = "PANCHPOKHARI AT GLANCE";
        break;
      case MenuType.destinations:
        value = "DESTINATIONS";
        break;
      case MenuType.eBrochure:
        value = "E-BROCHURE";
        break;
      case MenuType.travelDesk:
        value = "TRAVEL DESK";
        break;
      case MenuType.smartAssist:
        value = "SMART ASSIST";
        break;
      case MenuType.tourPackages:
        value = "TOUR PACKAGES";
        break;
      case MenuType.myTrips:
        value = "MY TRIPS";
        break;
      case MenuType.nearBy:
        value = "NEAR BY";
        break;
      case MenuType.socialChannels:
        value = "SOCIAL CHANNELS";
        break;
      case MenuType.settings:
        value = "SETTINGS";
        break;
    }
    return value;
  }
}
