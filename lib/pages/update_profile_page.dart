import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tourism/widgets/horizontal_line.dart';

import '../data/pojo/auth_body.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/root_screen.dart';
import '../utils/api_request.dart';
import '../widgets/gradient_button.dart';
import '../widgets/progress_dialog.dart';

class UpdateProfilePage extends StatefulWidget {
  final User user;

  UpdateProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  static const _KEY_FIRST_NAME = "firstName";
  static const _KEY_LAST_NAME = "lastName";
  static const _KEY_PROFILE_IMAGE = "profileImage";

  bool isPasswordEnabled = true;
  String? gender = 'SELECT GENDER';
  String? selectedDate;
  File? imageFile;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        helpText: "SELECT DOB",
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController imageController = TextEditingController();

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

    firstNameController.dispose();
    lastNameController.dispose();
    imageController.dispose();
  }

  bool _validateEmail({bool displayError = true}) {
    _clearError(_KEY_FIRST_NAME);
    bool isValid = true;
    String value = firstNameController.value.text;
    if (value.isEmpty) {
      formErrors[_KEY_FIRST_NAME] = "Email is required.";
      isValid = false;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value)) {
      formErrors[_KEY_FIRST_NAME] = "Email is not valid.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(_KEY_FIRST_NAME)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validatePassword({bool displayError = true}) {
    _clearError(_KEY_LAST_NAME);
    bool isValid = true;
    String value = lastNameController.value.text;
    if (value.isEmpty) {
      formErrors[_KEY_LAST_NAME] = "Password is required.";
      isValid = false;
    } else if (value.length < 6) {
      formErrors[_KEY_LAST_NAME] =
          "Password must be at-least six characters long.";
      isValid = false;
    } else if (!RegExp(
            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{6,}$")
        .hasMatch(value)) {
      formErrors[_KEY_LAST_NAME] =
          "Password must al-least contain one uppercase letter, one special character, and one number.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(_KEY_LAST_NAME)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validateCPassword({bool displayError = true}) {
    _clearError(_KEY_PROFILE_IMAGE);
    bool isValid = true;
    String value = imageController.value.text;
    String password = lastNameController.value.text;
    if (value.isEmpty) {
      formErrors[_KEY_PROFILE_IMAGE] = "Password is required.";
      isValid = false;
    } else if (value.length < 6) {
      formErrors[_KEY_PROFILE_IMAGE] =
          "Password must be at-least six characters long.";
      isValid = false;
    } else if (!RegExp(
            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{6,}$")
        .hasMatch(value)) {
      formErrors[_KEY_PROFILE_IMAGE] =
          "Password must at-least contain one uppercase and lowercase letter, one special character, and one number.";
      isValid = false;
    } else if (value != password) {
      formErrors[_KEY_PROFILE_IMAGE] =
          "Confirm password doesn't match with password.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(_KEY_PROFILE_IMAGE)) {
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

  Future<void> _showModalBottomSheetToSelectImageSource() async {
    ImageSource? imageSource = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: Text(
                    'SELECT IMAGE FROM',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              HorizontalLine(),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GridTileBar(
                    leading: Icon(
                      FaIcon(FontAwesomeIcons.images).icon,
                      color: Colors.grey.shade800,
                    ),
                    title: Text(
                      "GALLERY",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: GridTileBar(
                    leading: Icon(
                      FaIcon(FontAwesomeIcons.camera).icon,
                      color: Colors.grey.shade800,
                    ),
                    title: Text(
                      "CAMERA",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (imageSource != null) {
      XFile? xFile =
          await ImagePicker().pickImage(source: imageSource, maxWidth: 400);
      if (xFile != null) {
        File file = File(xFile.path);
        setState(() {
          imageFile = file;
        });
      }
    }
  }

  Future<void> _onFormSubmitted(BuildContext context) async {
    if (_validate()) {
      showDialog(
        context: context,
        builder: (_) => ProgressDialog(message: "LOADING..."),
        barrierDismissible: false,
      );
      AuthBody body = AuthBody(
        email: firstNameController.text,
        password: lastNameController.text,
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
                userId: "",
                userName: body.email,
                firstName: "",
                lastName: "",
                profileId: "",
                profileImage: "",
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            if (hasFocus)
                              _clearError(_KEY_FIRST_NAME);
                            else
                              _validateEmail();
                          },
                          child: TextFormField(
                            controller: firstNameController,
                            focusNode: emailFocusNode,
                            decoration: InputDecoration(
                              errorText: formErrors[_KEY_FIRST_NAME],
                              errorMaxLines: 2,
                              contentPadding:
                                  EdgeInsets.only(left: 12, right: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(1.0),
                                ),
                              ),
                              labelText: "FIRST NAME",
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
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        flex: 1,
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            if (hasFocus)
                              _clearError(_KEY_LAST_NAME);
                            else
                              _validateEmail();
                          },
                          child: TextFormField(
                            controller: firstNameController,
                            focusNode: emailFocusNode,
                            decoration: InputDecoration(
                              errorText: formErrors[_KEY_LAST_NAME],
                              errorMaxLines: 2,
                              contentPadding:
                                  EdgeInsets.only(left: 12, right: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(1.0),
                                ),
                              ),
                              labelText: "LAST NAME",
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Focus(
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: gender,
                                icon:
                                    const Icon(Icons.keyboard_arrow_down_sharp),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: SizedBox.shrink(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    gender = newValue!;
                                  });
                                },
                                items: [
                                  'SELECT GENDER',
                                  'MALE',
                                  'FEMALE',
                                  'OTHERS'
                                ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      enabled: value != 'SELECT GENDER',
                                      value: value,
                                      child: Text(
                                        value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                                color: Colors.grey.shade600),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.grey,
                              width: 1,
                              style: BorderStyle.solid,
                            )),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedDate ?? "SELECT DOB",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: Colors.grey.shade600),
                                  ),
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.grey.shade600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            if (hasFocus)
                              _clearError(_KEY_FIRST_NAME);
                            else
                              _validateEmail();
                          },
                          child: TextFormField(
                            controller: firstNameController,
                            focusNode: emailFocusNode,
                            decoration: InputDecoration(
                              errorText: formErrors[_KEY_FIRST_NAME],
                              errorMaxLines: 2,
                              contentPadding:
                                  EdgeInsets.only(left: 12, right: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(1.0),
                                ),
                              ),
                              labelText: "COUNTRY",
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
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        flex: 1,
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            if (hasFocus)
                              _clearError(_KEY_LAST_NAME);
                            else
                              _validateEmail();
                          },
                          child: TextFormField(
                            controller: firstNameController,
                            focusNode: emailFocusNode,
                            decoration: InputDecoration(
                              errorText: formErrors[_KEY_LAST_NAME],
                              errorMaxLines: 2,
                              contentPadding:
                                  EdgeInsets.only(left: 12, right: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(1.0),
                                ),
                              ),
                              labelText: "CITY",
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus)
                        _clearError(_KEY_LAST_NAME);
                      else
                        _validatePassword();
                    },
                    child: TextFormField(
                      controller: lastNameController,
                      focusNode: passwordFocusNode,
                      decoration: InputDecoration(
                        errorText: formErrors[_KEY_LAST_NAME],
                        errorMaxLines: 2,
                        contentPadding: EdgeInsets.only(left: 12, right: 12),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(1.0),
                          ),
                        ),
                        labelText: "ADDRESS",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.grey.shade600),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(cPasswordFocusNode),
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(75),
                          child: Container(
                            height: 150,
                            width: 150,
                            child: imageFile != null
                                ? Image.file(
                                    imageFile!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/images/default_user.png",
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        flex: 1,
                        child: OutlinedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder())),
                          onPressed: () =>
                              _showModalBottomSheetToSelectImageSource(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 12.0),
                            child: Text(
                              "SELECT IMAGE",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  GradientButton(
                    text: "UPDATE PROFILE",
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
