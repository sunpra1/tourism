import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism/providers/active_drawer_menu_provider.dart';
import 'package:tourism/providers/drawer_menu_items_provider.dart';
import 'package:tourism/screens/register_screen.dart';
import 'package:tourism/screens/root_screen.dart';
import 'package:tourism/utils/app_theme.dart';

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
          colorScheme: AppTheme.colorScheme,
          textTheme: AppTheme.textTheme,
        ),
        home: RootScreen(),
        routes: {
          RootScreen.routeName: (_) => RootScreen(),
          RegisterScreen.routeName: (_) => RegisterScreen(),
        },
      ),
    );
  }
}
