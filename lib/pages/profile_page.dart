import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourism/utils/app_theme.dart';

import '../models/user.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.backgroundGradient,
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18))),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  ProfileItem(
                    icon: FaIcon(FontAwesomeIcons.userAlt).icon,
                    label: "FULL NAME",
                    details: "${user.firstName} ${user.lastName}",
                  ),
                  ProfileItem(
                    icon: FaIcon(FontAwesomeIcons.solidEnvelope).icon,
                    label: "EMAIL",
                    details: user.userName,
                  ),
                  ProfileItem(
                    icon: FaIcon(FontAwesomeIcons.userShield).icon,
                    label: "ROLE",
                    details: user.roleName.value,
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0, -300),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: user.profileImage.isNotEmpty
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(user.profileImage),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage("assets/images/default_user.png"),
                        ),
                ),
              ),
            ),
          ],
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
