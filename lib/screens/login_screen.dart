import 'package:flutter/material.dart';
import 'package:tourism/pages/login_page.dart';
import 'package:tourism/pages/register_page.dart';

import '../widgets/my_app_bar.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: LoginPage(),
    );;
  }
}
