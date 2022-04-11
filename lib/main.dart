import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'providers/active_drawer_menu_provider.dart';
import 'providers/user_provider.dart';
import 'screens/loading_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/register_screen.dart';
import 'screens/root_screen.dart';
import 'screens/update_profile_screen.dart';
import 'screens/view_blog_screen.dart';
import 'screens/view_destination_screen.dart';
import 'screens/view_image_screen.dart';
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
            fontFamily: AppTheme.fontFamilySans),
        home: Consumer<UserProvider>(
          builder: (_, userProvider, __) {
            return FutureBuilder(
              future: userProvider.getLoggedInUser(),
              builder: (_, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return LoadingScreen();
                }
                User? user = snapshot.data as User?;
                if (user != null &&
                    (user.firstName.isEmpty ||
                        user.lastName.isEmpty ||
                        user.profileImage.isEmpty)) {
                  // return UpdateProfileScreen();
                  return RootScreen();
                }
                return RootScreen();
              },
            );
          },
        ),
        routes: {
          RootScreen.routeName: (_) => RootScreen(),
          RegisterScreen.routeName: (_) => RegisterScreen(),
          ViewDestinationScreen.routeName: (_) => ViewDestinationScreen(),
          LoginScreen.routeName: (_) => LoginScreen(),
          ProfileScreen.routeName: (_) => ProfileScreen(),
          ViewBlogScreen.routeName: (_) => ViewBlogScreen(),
          ViewImageScreen.routeName: (_) => ViewImageScreen(),
        },
      ),
    );
  }
}
