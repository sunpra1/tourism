import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/active_drawer_menu_provider.dart';
import 'providers/user_provider.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/register_screen.dart';
import 'screens/root_screen.dart';
import 'screens/view_destination_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ActiveDrawerMenuProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
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
          ViewDestinationScreen.routeName: (_) => ViewDestinationScreen(),
          LoginScreen.routeName: (_) => LoginScreen(),
          ProfileScreen.routeName: (_) => ProfileScreen(),
        },
      ),
    );
  }
}
