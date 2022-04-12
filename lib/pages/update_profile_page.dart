import 'dart:convert' as Convert;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  bool isValueSet = false;
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
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (!isValueSet) {
      User user = widget.user;
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      countryController.text = user.country;
      cityController.text = user.city;
      addressController.text = user.address;
      if (user.gender.isNotEmpty) {
        gender = user.gender;
      }
      isValueSet = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    countryController.dispose();
    cityController.dispose();
    addressController.dispose();

    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    countryFocusNode.dispose();
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

  Future<void> _onFormSubmitted(BuildContext context) async {
    User? user = context.read<UserProvider>().loggedInUser;
    if (user != null) {
      user.firstName = firstNameController.text;
      user.lastName = lastNameController.text;
      user.gender = gender ?? "";
      user.country = countryController.text;
      user.city = cityController.text;
      user.address = addressController.text;

      showDialog(
        context: context,
        builder: (_) => ProgressDialog(message: "LOADING..."),
        barrierDismissible: false,
      );
      Map<String, dynamic> body = user.toMap();
      if (imageFile != null)
        body.putIfAbsent(
          "profileShorImage",
          () =>
              "data:image/jpeg;base64,${Convert.base64Encode(imageFile!.readAsBytesSync())}",
        );

      print(body["profileShorImage"]);
      print(Convert.jsonEncode(body));
      APIResponse response = await APIRequest<Map<String, dynamic>>(
        requestType: RequestType.post,
        requestEndPoint: RequestEndPoint.updateProfile,
        body: body,
      ).make();
      print("HERE2");
      Navigator.of(context).pop();
      if (response.success) {
        context.read<UserProvider>().setLoggedInUser(user);
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
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: gender,
                              icon: const Icon(Icons.keyboard_arrow_down_sharp),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
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
                        child: TextFormField(
                          controller: countryController,
                          focusNode: countryFocusNode,
                          decoration: InputDecoration(
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
                              .requestFocus(cityFocusNode),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          controller: cityController,
                          focusNode: cityFocusNode,
                          decoration: InputDecoration(
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
                              .requestFocus(addressFocusNode),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  TextFormField(
                    controller: addressController,
                    focusNode: addressFocusNode,
                    decoration: InputDecoration(
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
