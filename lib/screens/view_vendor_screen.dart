import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tourism/models/VendorDetails.dart';
import 'package:url_launcher/url_launcher.dart' as Launcher;

import '../models/api_response.dart';
import '../utils/api_request.dart';
import '../widgets/progress_dialog.dart';

class ViewVendorScreen extends StatelessWidget {
  static const String routeName = "/viewVendorScreen";

  const ViewVendorScreen({Key? key}) : super(key: key);

  Future<VendorDetails?> _getVendor(BuildContext context) async {
    final String vendorId =
        ModalRoute.of(context)!.settings.arguments as String;
    try {
      APIResponse response = await APIRequest<Map<String, dynamic>>(
        requestType: RequestType.get,
        requestEndPoint: RequestEndPoint.vendor,
      ).make(pathParams: [vendorId]);
      if (response.success)
        return VendorDetails.formMap(response.data);
      else
        throw Exception();
    } on Exception catch (_) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: Text("ERROR"),
          content: Text("Unable to load vendor details."),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"))
          ],
        ),
      );
      Navigator.of(context).pop();
    }
    return null;
  }

  _sendEmailToVendor(String emailId) async {
    final String emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailId,
    ).toString();
    if (await Launcher.canLaunch(emailLaunchUri)) {
      await Launcher.launch(emailLaunchUri);
    }
  }

  _visitUrl(String url) async {
    if (await Launcher.canLaunch(url)) {
      await Launcher.launch(url);
    }
  }

  _callToVendor(String phoneNumber) async {
    final String emailLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    ).toString();
    if (await Launcher.canLaunch(emailLaunchUri)) {
      await Launcher.launch(emailLaunchUri);
    }
  }

  Future<Position?> _getCurrentLocation(BuildContext context) async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: Text("ERROR"),
          content: Text("Location service is not unavailable"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"))
          ],
        ),
      );
      return null;
    }

    if (await Geolocator.checkPermission() == LocationPermission.denied &&
        await Geolocator.requestPermission() == LocationPermission.denied) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: Text("DENIED PERMISSION"),
          content:
          Text("Permission is denied to access your current location."),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"))
          ],
        ),
      );
      return null;
    } else {
      return await Geolocator.getCurrentPosition();
    }
  }

  Future<void> _goToGoogleMap(BuildContext context, VendorDetails vendor) async {
    showDialog(
        context: context,
        builder: (_) => ProgressDialog(message: "LOCATING YOU..."));
    Position? position = await _getCurrentLocation(context);
    if (position != null) {
      String url =
          'https://www.google.com/maps/dir/?api=1&origin=${position.latitude},${position.longitude}&destination=${vendor.latitude},${vendor.longitude}&travelmode=driving&dir_action=navigate';
      if (await Launcher.canLaunch(url)) {
        await Launcher.launch(url);
      }
    }
    Navigator.of(context).pop();
  }

  Future<void> _showInfoDialog(
      BuildContext context, VendorDetails vendor) async {
    showDialog(
      context: context,
      builder: (_) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              height: 150,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      "CONTACT DETAILS",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    TextButton(
                      onPressed: () => _callToVendor(vendor.phoneNumber),
                      child: Row(
                        children: [
                          Text(
                            vendor.phoneNumber,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Spacer(),
                          Icon(
                            FaIcon(FontAwesomeIcons.phone).icon,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => _sendEmailToVendor(vendor.emailId),
                      child: Row(
                        children: [
                          Text(
                            vendor.emailId,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Spacer(),
                          Icon(
                            FaIcon(FontAwesomeIcons.envelope).icon,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getVendor(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
              body: ProgressDialog(message: "LOADING...", wrap: false),
            );
          }
          VendorDetails? vendor = snapshot.data as VendorDetails?;
          return vendor != null
              ? Scaffold(
                  body: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          snap: false,
                          floating: false,
                          expandedHeight: 250.0,
                          actions: [
                            FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: InkWell(
                                    onTap: () =>
                                        _showInfoDialog(context, vendor),
                                    child: Center(
                                      child: Icon(
                                        FaIcon(FontAwesomeIcons.phone).icon,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: 8,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: InkWell(
                                    onTap: () => _goToGoogleMap(context, vendor),
                                    child: Center(
                                      child: Icon(
                                        FaIcon(FontAwesomeIcons.mapMarker).icon,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: 8,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            title: Transform.translate(
                              offset: Offset(0, -25),
                              child: FittedBox(
                                child: Text(
                                  vendor.name.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            centerTitle: false,
                            background: Image.network(
                              "https://${APIRequest.baseUrl}/${vendor.banner}",
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, widget, loadingProgress) {
                                if (loadingProgress == null) return widget;
                                return Center(
                                  child: SizedBox(
                                    height: 64,
                                    width: 64,
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(60),
                            child: Transform.translate(
                              offset: Offset(0, 30),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        width: 3, color: Colors.white)),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    "https://${APIRequest.baseUrl}${vendor.logo}",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Transform.translate(
                            offset: Offset(0, 30),
                            child: Container(
                              width: double.infinity,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if (vendor.facebookLink != null &&
                                            vendor.facebookLink!.isNotEmpty)
                                          IconButton(
                                            onPressed: () =>
                                                _visitUrl(vendor.facebookLink!),
                                            color: Colors.blue,
                                            icon:
                                                FaIcon(FontAwesomeIcons.facebook),
                                          ),
                                        if (vendor.youtubeLink != null &&
                                            vendor.youtubeLink!.isNotEmpty)
                                          IconButton(
                                            onPressed: () =>
                                                _visitUrl(vendor.youtubeLink!),
                                            color: Colors.red,
                                            icon:
                                                FaIcon(FontAwesomeIcons.youtube),
                                          ),
                                        if (vendor.instagramLink != null &&
                                            vendor.instagramLink!.isNotEmpty)
                                          IconButton(
                                            onPressed: () =>
                                                _visitUrl(vendor.instagramLink!),
                                            color: Colors.red,
                                            icon: FaIcon(
                                                FontAwesomeIcons.instagram),
                                          ),
                                        if (vendor.linkedInLink != null &&
                                            vendor.linkedInLink!.isNotEmpty)
                                          IconButton(
                                            onPressed: () {},
                                            color: Colors.blue.shade800,
                                            icon:
                                                FaIcon(FontAwesomeIcons.linkedin),
                                          ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 32.0,
                                      ),
                                      child: HtmlWidget(
                                        vendor.details,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox.shrink();
        },
      ),
    );
  }
}
