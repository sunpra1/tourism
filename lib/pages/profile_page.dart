import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourism/utils/api_request.dart';

import '../models/user.dart';
import '../utils/app_theme.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.backgroundGradient,
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 36.0, right: 36.0, top: 50),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.translate(
                  offset: Offset(0, -50),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Center(
                      child: user.profileShortImage.isNotEmpty
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  "https://${APIRequest.baseUrl}${user.profileShortImage}"),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage("assets/images/default_user.png"),
                            ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -50),
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      ProfileItem(
                        icon: FaIcon(FontAwesomeIcons.userAlt).icon,
                        label: "FULL NAME",
                        details:
                            "${user.firstName} ${user.lastName}",
                      ),
                      ProfileItem(
                        icon: FaIcon(FontAwesomeIcons.solidEnvelope).icon,
                        label: "EMAIL",
                        details: user.userName,
                      ),
                      user.mobileNumber.isNotEmpty
                          ? ProfileItem(
                              icon: FaIcon(FontAwesomeIcons.phone).icon,
                              label: "MOBILE NUMBER",
                              details: user.mobileNumber,
                            )
                          : SizedBox.shrink(),
                      user.country.isNotEmpty
                          ? ProfileItem(
                              icon: FaIcon(FontAwesomeIcons.map).icon,
                              label: "COUNTRY",
                              details: user.country,
                            )
                          : SizedBox.shrink(),
                      user.state.isNotEmpty
                          ? ProfileItem(
                              icon: FaIcon(FontAwesomeIcons.mapMarker).icon,
                              label: "STATE",
                              details: user.state,
                            )
                          : SizedBox.shrink(),
                      user.city.isNotEmpty
                          ? ProfileItem(
                              icon: FaIcon(FontAwesomeIcons.mapMarked).icon,
                              label: "CITY",
                              details: user.city,
                            )
                          : SizedBox.shrink(),
                      user.city.isNotEmpty
                          ? ProfileItem(
                              icon: FaIcon(FontAwesomeIcons.mapPin).icon,
                              label: "ADDRESS",
                              details: user.address,
                            )
                          : SizedBox.shrink(),
                      ProfileItem(
                        icon: FaIcon(FontAwesomeIcons.userShield).icon,
                        label: "ROLE",
                        details: user.roleName.value,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String details;

  ProfileItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 12,
                      color: Colors.indigo,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        label,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Text(
                details,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
