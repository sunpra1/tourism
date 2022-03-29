import 'package:flutter/material.dart';
import 'package:tourism/pages/register_page.dart';

import '../widgets/my_app_bar.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = "/register";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: RegisterPage(),
    );;
  }
}
