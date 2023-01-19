import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tourism/data/api_service.dart';
import 'package:tourism/data/pojo/login_response.dart';
import 'package:tourism/screens/update_profile_screen.dart';
import 'package:tourism/utils/utils.dart';

import '../models/user.dart';
import '../pages/failed_getting_data_page.dart';
import '../pages/profile_page.dart';
import '../providers/user_provider.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/progress_dialog.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<User?> _getUserProfile(BuildContext context) async {
    try {
      User user = context
          .read<UserProvider>()
          .loggedInUser!;
      LoginResponse response = await APIService(Utils.getDioWithInterceptor())
          .getProfile(user.profileId);
      if (response.success && response.data != null) {
        User userProfile = response.data!;
        userProfile.userName = user.userName;
        userProfile.token = user.token;
        userProfile.userId = user.userId;
        userProfile.profileId = user.profileId;
        return userProfile;
      } else {
        return null;
      }
    }catch (e){
      log(e.toString());
      return null;
    }
  }

  Future<void> _goToUpdateProfileScreenAndHandleReturnValue(
      BuildContext context) async {
    await Navigator.of(context).pushNamed(UpdateProfileScreen.routeName);
    setState(() {});
  }

  _retry() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "PROFILE",
        actions: [
          IconButton(
            iconSize: 16,
            icon: Icon(FaIcon(FontAwesomeIcons.userEdit).icon),
            onPressed: () =>
                _goToUpdateProfileScreenAndHandleReturnValue(context),
          ),
        ],
      ),
      body: FutureBuilder<User?>(
          future: _getUserProfile(context),
          builder: (_, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return ProgressDialog(message: "LOADING...", wrap: false);
            }

            User? userProfile = snapshot.data;

            if (userProfile == null) {
              return FailedGettingData(
                onClick: _retry,
              );
            }

            return ProfilePage(user: userProfile);
          }),
    );
  }
}
