import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordEnabled = true;

  TextEditingController imageController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode usernameFocusNode = FocusNode();

  FocusNode passwordFocusNode = FocusNode();

  HashMap<String, String> formValues = HashMap<String, String>();

  @override
  void dispose() {
    super.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  void _onFormSubmitted() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      formKey.currentState!.save();
      //TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shadowColor: Colors.black,
            elevation: 8,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      focusNode: usernameFocusNode,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(1.0),
                          ),
                        ),
                        labelText: "USERNAME",
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(usernameFocusNode),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username is required";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null && value.isNotEmpty) {
                          formValues["username"] = value;
                        }
                      },
                    ),
                    const SizedBox(height: 18.0),
                    TextFormField(
                      focusNode: passwordFocusNode,
                      decoration: InputDecoration(
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
                      onFieldSubmitted: (_) => _onFormSubmitted(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null && value.isNotEmpty) {
                          formValues["password"] = value;
                        }
                      },
                    ),
                    const SizedBox(height: 18.0),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.secondary),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                          ),
                        ),
                        onPressed: () => _onFormSubmitted(),
                        child: const Text("LOGIN"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
