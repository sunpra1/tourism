import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../pages/update_profile_page.dart';
import '../providers/user_provider.dart';
import '../widgets/my_app_bar.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = context.watch<UserProvider>().loggedInUser!;

    return Scaffold(
      appBar: MyAppBar(
        title: "PROFILE",
      ),
      body: UpdateProfilePage(user: user),
    );
  }
}
