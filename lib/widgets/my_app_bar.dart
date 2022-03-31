import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const String appTitle = "NEPAL TOURISM";
  final String? title;

  MyAppBar({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? appTitle),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
