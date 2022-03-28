import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism/providers/active_drawer_menu_provider.dart';
import 'package:tourism/providers/drawer_menu_items_provider.dart';
import 'package:tourism/screens/root_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DrawerMenuItemsProvider()),
        ChangeNotifierProvider(create: (_) => ActiveDrawerMenuProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'KERALA TOURISM',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: RootScreen()),
    );
  }
}
