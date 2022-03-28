import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "/register";

  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isPasswordEnabled = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileNumberFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode cPasswordFocusNode = FocusNode();

  HashMap<String, String> formValues = HashMap<String, String>();

  @override
  void dispose() {
    super.dispose();
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    mobileNumberFocusNode.dispose();
    passwordFocusNode.dispose();
    cPasswordFocusNode.dispose();
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
                      focusNode: fullNameFocusNode,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(1.0),
                          ),
                        ),
                        labelText: "FULL NAME",
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(emailFocusNode),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Full name is required";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        formValues["fullName"] = value!;
                      },
                    ),
                    const SizedBox(height: 18.0),
                    TextFormField(
                      focusNode: emailFocusNode,
                      decoration: const InputDecoration(
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
                          .requestFocus(mobileNumberFocusNode),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        } else if (!RegExp(
                                "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}\$")
                            .hasMatch(value)) {
                          return "Please provide valid email address";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        formValues["email"] = value!;
                      },
                    ),
                    const SizedBox(height: 18.0),
                    TextFormField(
                      focusNode: mobileNumberFocusNode,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(1.0),
                          ),
                        ),
                        labelText: "MOBILE NUMBER",
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(passwordFocusNode),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Mobile number is required";
                        } else if (!RegExp(
                                "^([1-9]\d{2})([- .])(\d{3})\$2(\d{4})\$")
                            .hasMatch(value)) {
                          return "Please provide valid mobile number";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null && value.isNotEmpty) {
                          formValues["mobileNumber"] = value;
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
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(cPasswordFocusNode),
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
                    TextFormField(
                      focusNode: cPasswordFocusNode,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(1.0),
                          ),
                        ),
                        labelText: "CONFIRM PASSWORD",
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
                          return "Confirm password is required";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null && value.isNotEmpty) {
                          formValues["cPassword"] = value;
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
