import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism/models/proximity_type.dart';
import 'package:tourism/pages/application_details.dart';
import 'package:tourism/pages/blogs_page.dart';
import 'package:tourism/pages/images_page.dart';
import 'package:tourism/pages/map_page.dart';
import 'package:tourism/pages/proximity_page.dart';
import 'package:tourism/pages/video_page.dart';

import '../models/menu.dart';
import '../pages/home_page.dart';
import '../providers/active_drawer_menu_provider.dart';
import '../widgets/app_bottom_navigation_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/my_app_bar.dart';

class RootScreen extends StatelessWidget {
  static const String routeName = "/rootScreen";

  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MenuType selectedMenu =
        context.watch<ActiveDrawerMenuProvider>().activeDrawerMenuType;

    Widget page;
    String? title = selectedMenu.value;
    switch (selectedMenu) {
      case MenuType.home:
        page = HomePage();
        break;
      case MenuType.blog:
        page = BlogsPage();
        break;
      case MenuType.images:
        page = ImagesPage();
        break;
      case MenuType.videos:
        page = VideosPage();
        break;
      case MenuType.aboutUs:
        page = ApplicationDetails(drawerMenuType: MenuType.aboutUs);
        title = null;
        break;
      case MenuType.privacyPolicy:
        page = ApplicationDetails(drawerMenuType: MenuType.privacyPolicy);
        title = null;
        break;
      case MenuType.termsAndCondition:
        page = ApplicationDetails(
            drawerMenuType: MenuType.termsAndCondition);
        title = null;
        break;
      case MenuType.map:
        page = MapPage();
        title = "MAP";
        break;
      case MenuType.nearMe:
        page = ProximityPage(proximityType: ProximityType.nearMe);
        title = "NEAR ME";
        break;
      case MenuType.whereToStay:
        page = ProximityPage(proximityType: ProximityType.whereToStay);
        title = "WHERE TO STAY";
        break;
      default:
        page = HomePage();
        break;
    }

    return Scaffold(
      appBar: MyAppBar(
        title: title,
      ),
      body: page,
      drawer: AppDrawer(),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
