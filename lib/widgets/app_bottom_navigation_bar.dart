import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourism/models/bottom_navigation_bar_menu.dart';

import '../utils/app_theme.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarMenu> menus = [
      BottomNavigationBarMenu(
        bottomNavigationBarMenuType: BottomNavigationBarMenuType.nearMe,
        icon: FaIcon(FontAwesomeIcons.map).icon,
      ),
      BottomNavigationBarMenu(
        bottomNavigationBarMenuType: BottomNavigationBarMenuType.whereToStay,
        icon: FaIcon(FontAwesomeIcons.bed).icon,
      ),
      BottomNavigationBarMenu(
        bottomNavigationBarMenuType: BottomNavigationBarMenuType.essentials,
        icon: FaIcon(FontAwesomeIcons.boxOpen).icon,
      ),
      BottomNavigationBarMenu(
        bottomNavigationBarMenuType: BottomNavigationBarMenuType.createStory,
        icon: FaIcon(FontAwesomeIcons.images).icon,
      ),
      BottomNavigationBarMenu(
        bottomNavigationBarMenuType: BottomNavigationBarMenuType.askAQuery,
        icon: FaIcon(FontAwesomeIcons.comments).icon,
      ),
      BottomNavigationBarMenu(
        bottomNavigationBarMenuType: BottomNavigationBarMenuType.restrooms,
        icon: FaIcon(FontAwesomeIcons.restroom).icon,
      ),
      BottomNavigationBarMenu(
        bottomNavigationBarMenuType: BottomNavigationBarMenuType.audioGuide,
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
            bottomNavigationBarMenu: menus[index],
          ),
        ),
      ),
    );
  }
}

class AppBottomNavigationBarItem extends StatelessWidget {
  final BottomNavigationBarMenu bottomNavigationBarMenu;

  const AppBottomNavigationBarItem(
      {Key? key, required this.bottomNavigationBarMenu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4.0,
            vertical: 12.0,
          ),
          child: Container(
            width: 80,
            height: 48,
            child: Center(
              child: Column(
                children: [
                  Icon(
                    bottomNavigationBarMenu.icon,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  FittedBox(
                    child: Text(
                      BottomNavigationBarMenu.getOptionString(
                          bottomNavigationBarMenu.bottomNavigationBarMenuType),
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
