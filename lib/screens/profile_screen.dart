import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tourism/screens/update_profile_screen.dart';

import '../models/api_response.dart';
import '../models/user.dart';
import '../pages/profile_page.dart';
import '../providers/user_provider.dart';
import '../utils/api_request.dart';
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
    User user = context.read<UserProvider>().loggedInUser!;
    APIResponse response = await APIRequest<Map<String, dynamic>>(
      requestType: RequestType.get,
      requestEndPoint: RequestEndPoint.profile,
    ).make(pathParams: [user.profileId]);
    if (response.success) {
      User userProfile = User.fromMap(response.data);
      userProfile.userName = user.userName;
      userProfile.token = user.token;
      userProfile.userId = user.userId;
      userProfile.profileId = user.profileId;
      return userProfile;
    } else {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: Text("FAILED"),
          content:
              Text(response.message ?? "Unable to get your profile details."),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"))
          ],
        ),
      );
      Navigator.of(context).pop();
      return null;
    }
  }

  Future<void> _goToUpdateProfileScreenAndHandleReturnValue(
      BuildContext context) async {
    await Navigator.of(context).pushNamed(UpdateProfileScreen.routeName);
    setState(() {});
  }

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
      body: FutureBuilder(
          future: _getUserProfile(context),
          builder: (_, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return ProgressDialog(message: "LOADING...", wrap: false);
            }
            User? userProfile = snapshot.data as User?;
            return userProfile != null
                ? ProfilePage(user: userProfile)
                : SizedBox.shrink();
          }),
    );
  }
}
