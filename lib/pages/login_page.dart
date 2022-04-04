import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tourism/screens/register_screen.dart';
import 'package:tourism/widgets/gradient_button.dart';

import '../data/pojo/auth_body.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/root_screen.dart';
import '../utils/api_request.dart';
import '../widgets/progress_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const _KEY_PASSWORD = "password";
  static const _KEY_USERNAME = "userName";

  bool isPasswordEnabled = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  HashMap<String, String> formErrors = HashMap<String, String>();

  @override
  void dispose() {
    super.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();

    usernameController.dispose();
    passwordController.dispose();
  }

  bool _validateUsername({bool displayError = true}) {
    _clearError(_KEY_USERNAME);
    bool isValid = true;
    String value = usernameController.value.text;
    if (value.isEmpty) {
      formErrors[_KEY_USERNAME] = "Username is required.";
      isValid = false;
    } else if (!(RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value))) {
      formErrors[_KEY_USERNAME] = "Username must be valid email";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(_KEY_USERNAME)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validatePassword({bool displayError = true}) {
    _clearError(_KEY_PASSWORD);
    bool isValid = true;
    String value = passwordController.value.text;
    if (value.isEmpty) {
      formErrors[_KEY_PASSWORD] = "Password is required.";
      isValid = false;
    } else if (value.length < 6) {
      formErrors[_KEY_PASSWORD] =
          "Password must be at-least six characters long.";
      isValid = false;
    } else if (!RegExp(
            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{6,}$")
        .hasMatch(value)) {
      formErrors[_KEY_PASSWORD] =
          "Password must at-least contain one uppercase and lowercase letter, one special character, and one number.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(_KEY_PASSWORD)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validate() {
    bool isValid = true;
    if (!_validateUsername(displayError: false)) {
      isValid = false;
    }
    if (!_validatePassword(displayError: false)) {
      isValid = false;
    }
    if (!isValid) {
      setState(() {});
    }
    return isValid;
  }

  void _clearError(String key) {
    HashMap<String, String> newErrors = HashMap.from(formErrors);
    if (newErrors.containsKey(key)) {
      newErrors.remove(key);
    }
    setState(() {
      formErrors = newErrors;
    });
  }

  void _handleRegisterBtnClick(BuildContext context) {
    Navigator.of(context).pushNamed(RegisterScreen.routeName);
  }

  Future<void> _onFormSubmitted(BuildContext context) async {
    if (_validate()) {
      showDialog(
        context: context,
        builder: (_) => ProgressDialog(),
        barrierDismissible: false,
      );
      AuthBody body = AuthBody(
        email: usernameController.text,
        password: passwordController.text,
        authType: AuthType.login,
      );
      APIResponse response = await APIRequest<Map<String, dynamic>>(
              requestType: RequestType.post,
              requestEndPoint: RequestEndPoint.login,
              body: body.toMap())
          .make();
      Navigator.of(context).pop();
      if (response.success) {
        context.read<UserProvider>().setLoggedInUser(
              User.fromMap(response.data),
            );
        Navigator.of(context).pop(ModalRoute.withName(RootScreen.routeName));
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => AlertDialog(
            title: Text("LOGIN FAILED"),
            content: Text(response.message ??
                "Login failed, please try again sometime later."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"))
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            shadowColor: Colors.black,
            elevation: 8,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                children: [
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus)
                        _clearError(_KEY_USERNAME);
                      else
                        _validateUsername();
                    },
                    child: TextFormField(
                      controller: usernameController,
                      focusNode: usernameFocusNode,
                      decoration: InputDecoration(
                        errorText: formErrors[_KEY_USERNAME],
                        errorMaxLines: 2,
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(1.0),
                          ),
                        ),
                        labelText: "EMAIL",
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(usernameFocusNode),
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus)
                        _clearError(_KEY_PASSWORD);
                      else
                        _validatePassword();
                    },
                    child: TextFormField(
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      decoration: InputDecoration(
                        errorText: formErrors[_KEY_PASSWORD],
                        errorMaxLines: 2,
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(1.0),
                          ),
                        ),
                        labelText: "PASSWORD",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordEnabled = !isPasswordEnabled;
                            });
                          },
                          icon: isPasswordEnabled
                              ? Icon(FaIcon(FontAwesomeIcons.eye).icon)
                              : Icon(FaIcon(FontAwesomeIcons.eyeSlash).icon),
                        ),
                      ),
                      obscureText: isPasswordEnabled,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _onFormSubmitted(context),
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  GradientButton(
                    text: "LOGIN",
                    onPressed: () => _onFormSubmitted(context),
                  ),
                  const SizedBox(height: 18.0),
                  Text(
                    "IF YOUR ARE A NEW USER PLEASE CLICK ON REGISTER BUTTON.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 18.0),
                  GradientButton(
                    text: "REGISTER",
                    onPressed: () => _handleRegisterBtnClick(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
