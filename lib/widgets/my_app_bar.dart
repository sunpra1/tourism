import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const String appTitle = "NEPAL TOURISM";
  final String? title;
  final bool useDefaultTitle;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final IconThemeData? iconThemeData;

  MyAppBar({
    Key? key,
    this.title,
    this.actions,
    this.backgroundColor,
    this.iconThemeData,
    this.useDefaultTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      iconTheme: iconThemeData,
      backgroundColor: backgroundColor,
      title: Text(title ?? (useDefaultTitle ? appTitle : "")),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
