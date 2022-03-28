import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism/models/drawer_menu.dart';
import 'package:tourism/providers/drawer_menu_items_provider.dart';

import '../providers/active_drawer_menu_provider.dart';
import '../utils/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          decoration: AppTheme.backgroundGradient,
          child: Column(
            children: [
              AppDrawerBanner(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                child: Divider(
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: 24),
              AppDrawerMenu()
            ],
          ),
        ),
      ),
    );
  }
}

class AppDrawerBanner extends StatelessWidget {
  const AppDrawerBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              child: Image.asset("assets/images/abstract.png"),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "KERALA TOURISM",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(60, 36)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)))),
                    onPressed: () {},
                    child: Text(
                      "LOGIN",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white),
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class AppDrawerMenu extends StatelessWidget {
  const AppDrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DrawerMenu> _drawerMenus =
        context.watch<DrawerMenuItemsProvider>().drawerMenus;

    return Expanded(
      child: ListView.builder(
        itemBuilder: (_, index) => AppDrawerMenuItem(menu: _drawerMenus[index]),
        itemCount: _drawerMenus.length,
      ),
    );
  }
}

class AppDrawerMenuItem extends StatelessWidget {
  final DrawerMenu menu;

  const AppDrawerMenuItem({Key? key, required this.menu}) : super(key: key);

  void _handleOnAppDrawerMenuItemClicked(BuildContext context) {
    context
        .read<ActiveDrawerMenuProvider>()
        .setActiveDrawerMenu(menu.drawerMenuType);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    DrawerMenuType _activeMenu =
        context.watch<ActiveDrawerMenuProvider>().activeDrawerMenuType;
    Color backGroundColor = _activeMenu == menu.drawerMenuType
        ? Colors.green.shade800
        : Colors.transparent;

    return Material(
      color: backGroundColor,
      child: InkWell(
        onTap: () => _handleOnAppDrawerMenuItemClicked(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                menu.icon,
                size: 16,
                color: Colors.white,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    DrawerMenu.getOptionString(menu.drawerMenuType),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
