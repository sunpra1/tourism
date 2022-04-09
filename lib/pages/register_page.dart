import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../data/pojo/auth_body.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/root_screen.dart';
import '../utils/api_request.dart';
import '../widgets/gradient_button.dart';
import '../widgets/progress_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const _KEY_EMAIL = "email";
  static const _KEY_PASSWORD = "password";
  static const _KEY_CONFIRM_PASSWORD = "cPassword";

  bool isPasswordEnabled = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode cPasswordFocusNode = FocusNode();

  HashMap<String, String> formErrors = HashMap<String, String>();

  @override
  void dispose() {
    super.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    cPasswordFocusNode.dispose();

    emailController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
  }

  bool _validateEmail({bool displayError = true}) {
    _clearError(_KEY_EMAIL);
    bool isValid = true;
    String value = emailController.value.text;
    if (value.isEmpty) {
      formErrors[_KEY_EMAIL] = "Email is required.";
      isValid = false;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value)) {
      formErrors[_KEY_EMAIL] = "Email is not valid.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(_KEY_EMAIL)) {
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
          "Password must al-least contain one uppercase letter, one special character, and one number.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(_KEY_PASSWORD)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validateCPassword({bool displayError = true}) {
    _clearError(_KEY_CONFIRM_PASSWORD);
    bool isValid = true;
    String value = cPasswordController.value.text;
    String password = passwordController.value.text;
    if (value.isEmpty) {
      formErrors[_KEY_CONFIRM_PASSWORD] = "Password is required.";
      isValid = false;
    } else if (value.length < 6) {
      formErrors[_KEY_CONFIRM_PASSWORD] =
          "Password must be at-least six characters long.";
      isValid = false;
    } else if (!RegExp(
            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{6,}$")
        .hasMatch(value)) {
      formErrors[_KEY_CONFIRM_PASSWORD] =
          "Password must at-least contain one uppercase and lowercase letter, one special character, and one number.";
      isValid = false;
    } else if (value != password) {
      formErrors[_KEY_CONFIRM_PASSWORD] =
          "Confirm password doesn't match with password.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(_KEY_CONFIRM_PASSWORD)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validate() {
    bool isValid = true;
    if (!_validateEmail(displayError: false)) {
      isValid = false;
    }
    if (!_validatePassword(displayError: false)) {
      isValid = false;
    }
    if (!_validateCPassword(displayError: false)) {
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

  Future<void> _onFormSubmitted(BuildContext context) async {
    if (_validate()) {
      showDialog(
        context: context,
        builder: (_) => ProgressDialog(message: "LOADING..."),
        barrierDismissible: false,
      );
      AuthBody body = AuthBody(
        email: emailController.text,
        password: passwordController.text,
        authType: AuthType.register,
      );
      APIResponse response = await APIRequest<String>(
              requestType: RequestType.post,
              requestEndPoint: RequestEndPoint.register,
              body: body.toMap())
          .make();
      Navigator.of(context).pop();
      if (response.success) {
        context.read<UserProvider>().setLoggedInUser(
              User(
                userName: body.email,
                roleName: UserRole.user,
                token: response.data,
              ),
            );
        Navigator.of(context)
            .popUntil(ModalRoute.withName(RootScreen.routeName));
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => AlertDialog(
            title: Text("REGISTRATION FAILED"),
            content: Text(response.message ??
                "Registration failed, please try again sometime later."),
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
                        _clearError(_KEY_EMAIL);
                      else
                        _validateEmail();
                    },
                    child: TextFormField(
                      controller: emailController,
                      focusNode: emailFocusNode,
                      decoration: InputDecoration(
                        errorText: formErrors[_KEY_EMAIL],
                        errorMaxLines: 2,
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(1.0),
                          ),
                        ),
                        labelText: "EMAIL",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.grey.shade600),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(passwordFocusNode),
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
                        labelStyle: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.grey.shade600),
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
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(cPasswordFocusNode),
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus)
                        _clearError(_KEY_CONFIRM_PASSWORD);
                      else
                        _validateCPassword();
                    },
                    child: TextFormField(
                      controller: cPasswordController,
                      focusNode: cPasswordFocusNode,
                      decoration: InputDecoration(
                        errorText: formErrors[_KEY_CONFIRM_PASSWORD],
                        errorMaxLines: 2,
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(1.0),
                          ),
                        ),
                        labelText: "CONFIRM PASSWORD",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.grey.shade600),
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
                    text: "REGISTER",
                    onPressed: () => _onFormSubmitted(context),
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
