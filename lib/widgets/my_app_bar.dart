import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const String appTitle = "NEPAL TOURISM";
  final String? title;
  final List<Widget>? actions;

  MyAppBar({Key? key, this.title, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? appTitle),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
