import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourism/data/api_service.dart';
import 'package:tourism/data/pojo/vendors_response.dart';
import 'package:tourism/models/vendor.dart';
import 'package:tourism/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart' as Launcher;

import '../screens/view_vendor_screen.dart';
import '../utils/k.dart';
import '../widgets/progress_dialog.dart';
import 'failed_getting_data_page.dart';
import 'feels_lonely_here_page.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage({Key? key}) : super(key: key);

  @override
  State<VendorsPage> createState() => _VendorsPageState();
}

class _VendorsPageState extends State<VendorsPage> {
  Future<List<Vendor>?> _getVendors(BuildContext context) async {
    VendorsResponse vendorsResponse =
        await APIService(Utils.getDioWithInterceptor()).getVendors({
      "value": "",
      "category": "",
      "subCategory": "",
      "location": "",
      "page": 1,
      "pageSize": 30,
      "totalPage": 1
    });
    if (vendorsResponse.success)
      return vendorsResponse.data;
    else
      return null;
  }

  _retry() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: FutureBuilder<List<Vendor>?>(
        future: _getVendors(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return ProgressDialog(message: "LOADING...");
          }

          List<Vendor>? vendors = snapshot.data;

          if (vendors == null) {
            return FailedGettingData(
              onClick: _retry,
            );
          }

          if (vendors.isEmpty) {
            return FeelsLonelyHerePage(message: "No vendors available.");
          }

          return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemBuilder: (_, index) => VendorItem(
                      vendor: vendors[index],
                    ),
                    itemCount: vendors.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ),
                  ),
                );
        },
      ),
    );
  }
}

class VendorItem extends StatelessWidget {
  final Vendor vendor;

  const VendorItem({Key? key, required this.vendor}) : super(key: key);

  _sendEmailToVendor() async {
    if (vendor.emailId != null && vendor.emailId!.isNotEmpty) {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: vendor.emailId,
      );
      if (await Launcher.canLaunchUrl(emailLaunchUri)) {
        await Launcher.launchUrl(emailLaunchUri);
      }
    }
  }

  _callToVendor() async {
    if (vendor.phoneNumber != null && vendor.phoneNumber!.isNotEmpty) {
      final Uri emailLaunchUri = Uri(
        scheme: 'tel',
        path: vendor.phoneNumber,
      );
      if (await Launcher.canLaunchUrl(emailLaunchUri)) {
        await Launcher.launchUrl(emailLaunchUri);
      }
    }
  }

  Future<void> _showInfoDialog(BuildContext context) async {
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
                      onPressed: () => _callToVendor(),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              (vendor.phoneNumber != null &&
                                      vendor.phoneNumber!.isNotEmpty)
                                  ? vendor.phoneNumber!
                                  : "NOT AVAILABLE",
                              style: Theme.of(context).textTheme.labelMedium,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ),
                          Icon(
                            FaIcon(FontAwesomeIcons.phone).icon,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => _sendEmailToVendor(),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              (vendor.emailId != null &&
                                      vendor.emailId!.isNotEmpty)
                                  ? vendor.emailId!
                                  : "NOT AVAILABLE",
                              style: Theme.of(context).textTheme.labelMedium,
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ),
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
    return Card(
      shadowColor: Colors.black54,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                    ViewVendorScreen.routeName,
                    arguments: vendor.vendorInfoId),
                child: GridTile(
                  child: (vendor.banner == null || vendor.banner!.isEmpty)
                      ? Image.asset(
                          "assets/images/app_logo.png",
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          "${K.imageBaseUrl}${vendor.banner}",
                          fit: BoxFit.cover,
                          loadingBuilder: (context, widget, loadingProgress) {
                            if (loadingProgress == null) return widget;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: InkWell(
                            onTap: () => _showInfoDialog(context),
                            child: Center(
                              child: Icon(
                                FaIcon(FontAwesomeIcons.phone).icon,
                                color: Theme.of(context).colorScheme.secondary,
                                size: 8,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  footer: GridTileBar(
                    title: Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 3, color: Colors.white)),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              (vendor.logo == null || vendor.logo!.isEmpty)
                                  ? AssetImage(
                                      "assets/images/app_logo.png",
                                    ) as ImageProvider
                                  : NetworkImage(
                                      "${K.imageBaseUrl}${vendor.logo}",
                                    ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vendor.name,
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 2,
                  softWrap: true,
                ),
                FittedBox(
                  child: Text(
                    vendor.location,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
