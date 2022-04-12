import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism/pages/application_details.dart';
import 'package:tourism/pages/blogs_page.dart';
import 'package:tourism/pages/images_page.dart';
import 'package:tourism/pages/video_page.dart';

import '../models/drawer_menu.dart';
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
    DrawerMenuType selectedMenu =
        context.watch<ActiveDrawerMenuProvider>().activeDrawerMenuType;

    Widget page;
    String? title = selectedMenu.value;
    switch (selectedMenu) {
      case DrawerMenuType.home:
        page = HomePage();
        break;
      case DrawerMenuType.blog:
        page = BlogsPage();
        break;
      case DrawerMenuType.images:
        page = ImagesPage();
        break;
      case DrawerMenuType.videos:
        page = VideosPage();
        break;
      case DrawerMenuType.aboutUs:
        page = ApplicationDetails(drawerMenuType: DrawerMenuType.aboutUs);
        title = null;
        break;
      case DrawerMenuType.privacyPolicy:
        page = ApplicationDetails(drawerMenuType: DrawerMenuType.privacyPolicy);
        title = null;
        break;
      case DrawerMenuType.termsAndCondition:
        page = ApplicationDetails(
            drawerMenuType: DrawerMenuType.termsAndCondition);
        title = null;
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
