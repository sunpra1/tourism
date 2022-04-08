import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/drawer_menu.dart';
import '../models/user.dart';
import '../providers/active_drawer_menu_provider.dart';
import '../providers/user_provider.dart';
import '../screens/login_screen.dart';
import '../screens/profile_screen.dart';
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
              AppDrawerMenu(),
            ],
          ),
        ),
      ),
    );
  }
}

class AppDrawerBanner extends StatelessWidget {
  const AppDrawerBanner({Key? key}) : super(key: key);

  void _handleLoginBtnClick(BuildContext context) {
    Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  void _handleProfileBtnClick(BuildContext context) {
    Navigator.of(context).pushNamed(ProfileScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<UserProvider>().loggedInUser;

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
                      "NEPAL TOURISM",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    (user != null && user.firstName.isNotEmpty)
                        ? Text(
                            "${user.firstName} ${user.lastName}",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.white,
                                ),
                          )
                        : (user != null)
                            ? Text(
                                user.userName,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                              )
                            : SizedBox.shrink(),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.inversePrimary),
                          minimumSize: MaterialStateProperty.all(Size(60, 36)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)))),
                      onPressed: () => user == null
                          ? _handleLoginBtnClick(context)
                          : _handleProfileBtnClick(context),
                      child: Text(
                        user == null ? "LOGIN" : "PROFILE",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
    List<DrawerMenu> _drawerMenus = [
      DrawerMenu(
        drawerMenuType: DrawerMenuType.home,
        icon: FaIcon(FontAwesomeIcons.home).icon,
      ),
      DrawerMenu(
        drawerMenuType: DrawerMenuType.blog,
        icon: FaIcon(FontAwesomeIcons.newspaper).icon,
      ),
      DrawerMenu(
        drawerMenuType: DrawerMenuType.images,
        icon: FaIcon(FontAwesomeIcons.images).icon,
      ),
    ];

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

  void _handleOnAppDrawerMenuItemClick(BuildContext context) {
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
        ? Colors.black12
        : Colors.transparent;

    return Material(
      color: backGroundColor,
      child: InkWell(
        onTap: () => _handleOnAppDrawerMenuItemClick(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
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
