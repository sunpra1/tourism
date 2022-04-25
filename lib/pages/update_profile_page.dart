import 'dart:collection';
import 'dart:convert' as Convert;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:tourism/models/gender.dart';

import '../models/api_response.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';
import '../utils/api_request.dart';
import '../widgets/gradient_button.dart';
import '../widgets/horizontal_line.dart';
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
  static const _KEY_COUNTRY = "country";
  static const _KEY_STATE = "state";
  static const _KEY_CITY = "city";
  static const _KEY_ADDRESS = "address";

  bool isValueSet = false;
  bool isPasswordEnabled = true;
  Gender gender = Gender.unSpeacified;
  String? selectedDate;
  File? imageFile;

  HashMap<String, String> formErrors = HashMap<String, String>();

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
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode mobileNumberFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (!isValueSet) {
      User user = widget.user;
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      mobileNumberController.text = user.mobileNumber;
      countryController.text = user.country;
      stateController.text = user.state;
      cityController.text = user.city;
      addressController.text = user.address;
      gender = user.gender;
      isValueSet = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileNumberController.dispose();
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    addressController.dispose();

    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    mobileNumberFocusNode.dispose();
    countryFocusNode.dispose();
    stateFocusNode.dispose();
    cityFocusNode.dispose();
    addressFocusNode.dispose();
  }

  Future<void> _showModalBottomSheetToSelectImageSource() async {
    ImageSource? imageSource = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return Material(
          child: Container(
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
                InkWell(
                  onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      bottom: 8.0,
                      top: 8.0,
                    ),
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
                InkWell(
                  onTap: () => Navigator.of(context).pop(ImageSource.camera),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      bottom: 8.0,
                    ),
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

  void _clearError(String key) {
    HashMap<String, String> newErrors = HashMap.from(formErrors);
    if (newErrors.containsKey(key)) {
      newErrors.remove(key);
    }
    setState(() {
      formErrors = newErrors;
    });
  }

  bool _validateFirstName({bool displayError = true}) {
    _clearError(_KEY_FIRST_NAME);
    bool isValid = true;
    String value = firstNameController.value.text;
    if (value.isEmpty) {
      formErrors[_KEY_FIRST_NAME] = "Firstname is required.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(_KEY_FIRST_NAME)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validateLastName({bool displayError = true}) {
    _clearError(_KEY_LAST_NAME);
    bool isValid = true;
    String value = lastNameController.value.text;
    if (value.isEmpty) {
      formErrors[_KEY_LAST_NAME] = "Lastname is required.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(_KEY_LAST_NAME)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validateCountry({bool displayError = true}) {
    _clearError(_KEY_COUNTRY);
    bool isValid = true;
    String value = countryController.value.text;
    if (value.isEmpty) {
      formErrors[_KEY_COUNTRY] = "Country is required.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(_KEY_COUNTRY)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validateState({bool displayError = true}) {
    _clearError(_KEY_STATE);
    bool isValid = true;
    String value = stateController.value.text;
    if (value.isEmpty) {
      formErrors[_KEY_STATE] = "State is required.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(_KEY_STATE)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validateCity({bool displayError = true}) {
    _clearError(_KEY_CITY);
    bool isValid = true;
    String value = cityController.value.text;
    if (value.isEmpty) {
      formErrors[_KEY_CITY] = "City is required.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(_KEY_CITY)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validateAddress({bool displayError = true}) {
    _clearError(_KEY_ADDRESS);
    bool isValid = true;
    String value = addressController.value.text;
    if (value.isEmpty) {
      formErrors[_KEY_ADDRESS] = "Address is required.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(_KEY_ADDRESS)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validate() {
    bool isValid = true;
    if (!_validateFirstName(displayError: false)) {
      isValid = false;
    }
    if (!_validateLastName(displayError: false)) {
      isValid = false;
    }
    if (!_validateCountry(displayError: false)) {
      isValid = false;
    }
    if (!_validateState(displayError: false)) {
      isValid = false;
    }
    if (!_validateCity(displayError: false)) {
      isValid = false;
    }
    if (!_validateAddress(displayError: false)) {
      isValid = false;
    }
    if (!isValid) {
      setState(() {});
    }
    return isValid;
  }

  Future<void> _onFormSubmitted(BuildContext context) async {
    if (!_validate()) return;
    User? user = context.read<UserProvider>().loggedInUser;
    if (user != null) {
      user.firstName = firstNameController.text;
      user.lastName = lastNameController.text;
      user.gender = gender;
      user.country = countryController.text;
      user.state = stateController.text;
      user.city = cityController.text;
      user.address = addressController.text;

      showDialog(
        context: context,
        builder: (_) => ProgressDialog(message: "LOADING..."),
        barrierDismissible: false,
      );
      if (imageFile != null)
        user.profileShortImage =
            "data:image/jpeg;base64,${Convert.base64Encode(imageFile!.readAsBytesSync())}";

      Map<String, dynamic> body = user.toMap();
      APIResponse response = await APIRequest<Map<String, dynamic>>(
        requestType: RequestType.post,
        requestEndPoint: RequestEndPoint.updateProfile,
        body: body,
      ).make();
      Navigator.of(context).pop();
      if (response.success) {
        context.read<UserProvider>().setLoggedInUser(user);
        Navigator.of(context).pop();
        Toast.show(
          "Profile updated successfully.",
          duration: Toast.lengthLong,
          textStyle: Theme.of(context).textTheme.labelMedium,
        );
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => AlertDialog(
            title: Text("PROFILE UPDATE FAILED"),
            content: Text(response.message ??
                "Profile cannot be updated, please try again sometime later."),
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
    ToastContext().init(context);
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
                        child: TextFormField(
                          controller: firstNameController,
                          focusNode: firstNameFocusNode,
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
                              .requestFocus(lastNameFocusNode),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          controller: lastNameController,
                          focusNode: lastNameFocusNode,
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
                              .requestFocus(countryFocusNode),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  TextFormField(
                    controller: mobileNumberController,
                    focusNode: mobileNumberFocusNode,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 12, right: 12),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(1.0),
                        ),
                      ),
                      labelText: "MOBILE NUMBER",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Colors.grey.shade600),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
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
                            child: DropdownButton<Gender>(
                              isExpanded: true,
                              value: gender,
                              icon: const Icon(Icons.keyboard_arrow_down_sharp),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: SizedBox.shrink(),
                              onChanged: (Gender? newValue) {
                                setState(() {
                                  gender = newValue!;
                                });
                              },
                              items: [
                                Gender.unSpeacified,
                                Gender.male,
                                Gender.female,
                                Gender.others,
                              ].map<DropdownMenuItem<Gender>>(
                                (Gender value) {
                                  return DropdownMenuItem<Gender>(
                                    enabled: value != Gender.unSpeacified,
                                    value: value,
                                    child: Text(
                                      value.value,
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
                  TextFormField(
                    controller: addressController,
                    focusNode: addressFocusNode,
                    decoration: InputDecoration(
                      errorText: formErrors[_KEY_ADDRESS],
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
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(countryFocusNode),
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          controller: countryController,
                          focusNode: countryFocusNode,
                          decoration: InputDecoration(
                            errorText: formErrors[_KEY_COUNTRY],
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
                              .requestFocus(stateFocusNode),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          controller: stateController,
                          focusNode: stateFocusNode,
                          decoration: InputDecoration(
                            errorText: formErrors[_KEY_STATE],
                            errorMaxLines: 2,
                            contentPadding:
                                EdgeInsets.only(left: 12, right: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(1.0),
                              ),
                            ),
                            labelText: "STATE",
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: Colors.grey.shade600),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(cityFocusNode),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  TextFormField(
                    controller: cityController,
                    focusNode: cityFocusNode,
                    decoration: InputDecoration(
                      errorText: formErrors[_KEY_CITY],
                      errorMaxLines: 2,
                      contentPadding: EdgeInsets.only(left: 12, right: 12),
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
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(addressFocusNode),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Colors.grey.shade700),
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
