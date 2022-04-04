import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../pages/profile_page.dart';
import '../providers/user_provider.dart';
import '../widgets/my_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = context.watch<UserProvider>().loggedInUser!;

    return Scaffold(
      appBar: MyAppBar(
        title: "PROFILE",
        actions: [
          IconButton(
            iconSize: 16,
            icon: Icon(FaIcon(FontAwesomeIcons.userEdit).icon),
            onPressed: () {
              Navigator.of(context).pushNamed("");
            },
          ),
        ],
      ),
      body: ProfilePage(user: user),
    );
  }
}
