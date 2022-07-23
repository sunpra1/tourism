import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tourism/models/menu.dart';

import '../providers/active_drawer_menu_provider.dart';
import '../utils/app_theme.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Menu> menus = [
      Menu(
        menuType: MenuType.nearMe,
        icon: FaIcon(FontAwesomeIcons.map).icon,
      ),
      Menu(
        menuType: MenuType.whereToStay,
        icon: FaIcon(FontAwesomeIcons.bed).icon,
      ),
      Menu(
        menuType: MenuType.essentials,
        icon: FaIcon(FontAwesomeIcons.luggageCart).icon,
      ),
      Menu(
        menuType: MenuType.createStory,
        icon: FaIcon(FontAwesomeIcons.fileUpload).icon,
      ),
      Menu(
        menuType: MenuType.places,
        icon: FaIcon(FontAwesomeIcons.mapMarker).icon,
      ),
      Menu(
        menuType: MenuType.askAQuery,
        icon: FaIcon(FontAwesomeIcons.comments).icon,
      ),
      Menu(
        menuType: MenuType.restrooms,
        icon: FaIcon(FontAwesomeIcons.restroom).icon,
      ),
      Menu(
        menuType: MenuType.audioGuide,
        icon: FaIcon(FontAwesomeIcons.fileAudio).icon,
      ),
    ];

    return Container(
      decoration: BoxDecoration(gradient: AppTheme.gradientLR),
      child: SizedBox(
        width: double.infinity,
        height: 64,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: menus.length,
          itemBuilder: (_, index) => AppBottomNavigationBarItem(
            menu: menus[index],
          ),
        ),
      ),
    );
  }
}

class AppBottomNavigationBarItem extends StatelessWidget {
  final Menu menu;

  const AppBottomNavigationBarItem({Key? key, required this.menu})
      : super(key: key);

  void _handleOnBottomNavigationMenuItemClick(BuildContext context) {
    context.read<ActiveDrawerMenuProvider>().setActiveDrawerMenu(menu.menuType);
  }

  @override
  Widget build(BuildContext context) {
    MenuType _selectedMenu =
        context.watch<ActiveDrawerMenuProvider>().activeDrawerMenuType;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleOnBottomNavigationMenuItemClick(context),
        child: Container(
          color: menu.menuType == _selectedMenu ? Colors.black26 : null,
          width: 80,
          height: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 12.0,
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    menu.icon,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  FittedBox(
                    child: Text(
                      menu.menuType.value,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
