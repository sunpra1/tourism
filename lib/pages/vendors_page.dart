import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourism/models/vendor.dart';
import 'package:url_launcher/url_launcher.dart' as Launcher;

import '../models/api_response.dart';
import '../screens/view_vendor_screen.dart';
import '../utils/api_request.dart';
import '../widgets/progress_dialog.dart';

class VendorsPage extends StatelessWidget {
  const VendorsPage({Key? key}) : super(key: key);

  Future<List<Vendor>?> _getVendors(BuildContext context) async {
    APIResponse response = await APIRequest<List<dynamic>>(
        requestType: RequestType.post,
        requestEndPoint: RequestEndPoint.vendors,
        body: {
          "value": "",
          "category": "",
          "subCategory": "",
          "location": "",
          "page": 1,
          "pageSize": 30,
          "totalPage": 1
        }).make();
    if (response.success)
      return Vendor.fromListMap(response.data);
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: FutureBuilder(
        future: _getVendors(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return ProgressDialog(message: "LOADING...");
          }
          List<Vendor>? vendors = snapshot.data as List<Vendor>?;
          print("Vendor size is: ${vendors?.length}");
          return (vendors != null && vendors.length > 0)
              ? Padding(
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
                )
              : Center(
                  child: Text(
                    "NO VENDORS FOUND",
                    style: Theme.of(context).textTheme.labelMedium,
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
    final String emailLaunchUri = Uri(
      scheme: 'mailto',
      path: vendor.emailId,
    ).toString();
    if (await Launcher.canLaunch(emailLaunchUri)) {
      await Launcher.launch(emailLaunchUri);
    }
  }

  _callToVendor() async {
    final String emailLaunchUri = Uri(
      scheme: 'tel',
      path: vendor.phoneNumber,
    ).toString();
    if (await Launcher.canLaunch(emailLaunchUri)) {
      await Launcher.launch(emailLaunchUri);
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
                              vendor.phoneNumber,
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
                              "Email thayt is to ne baeru lo ngh and ashjo cia u injane kjuanl",
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
                  child: Image.network(
                    "https://${APIRequest.baseUrl}${vendor.banner}",
                    fit: BoxFit.cover,
                    loadingBuilder: (context, widget, loadingProgress) {
                      if (loadingProgress == null) return widget;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
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
                          backgroundImage: NetworkImage(
                            "https://${APIRequest.baseUrl}${vendor.logo}",
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
