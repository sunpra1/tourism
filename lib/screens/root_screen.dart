import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    switch (selectedMenu) {
      case DrawerMenuType.home:
        page = HomePage();
        break;
    }

    return Scaffold(
      appBar: MyAppBar(),
      body: page,
      drawer: AppDrawer(),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
