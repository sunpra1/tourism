import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:tourism/data/pojo/app_details_body.dart';
import 'package:tourism/models/drawer_menu.dart';
import 'package:tourism/models/pp_tc_faq_ab.dart';
import 'package:tourism/utils/app_theme.dart';

import '../models/api_response.dart';
import '../utils/api_request.dart';
import '../widgets/progress_dialog.dart';

class ApplicationDetails extends StatelessWidget {
  final DrawerMenuType drawerMenuType;

  const ApplicationDetails({Key? key, required this.drawerMenuType})
      : super(key: key);

  Future<PpTcFaqAb?> _getPpTcFaqAb(BuildContext context) async {
    FlagType flagType;
    switch (drawerMenuType) {
      case DrawerMenuType.aboutUs:
        flagType = FlagType.aboutUS;
        break;
      case DrawerMenuType.privacyPolicy:
        flagType = FlagType.privacyPolicy;
        break;
      default:
        flagType = FlagType.termsAndCondition;
        break;
    }
    try {
      APIResponse response = await APIRequest<Map<String, dynamic>>(
              requestType: RequestType.post,
              requestEndPoint: RequestEndPoint.appDetails,
              body: AppDetailsBody(flag: flagType).toMap())
          .make();
      if (response.success) {
        return PpTcFaqAb.fromMap(response.data);
      } else
        throw Exception();
    } on Exception catch (_) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: Text("ERROR"),
          content:
              Text("Unable to load ${drawerMenuType.value.toLowerCase()}."),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                drawerMenuType.value.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Colors.white),
              ),
              centerTitle: false,
              background: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.gradientTB,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder(
              future: _getPpTcFaqAb(context),
              builder: (_, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return ProgressDialog(
                    message: "LOADING...",
                    wrap: true,
                  );
                }
                PpTcFaqAb? ppTcFaqAb = snapshot.data as PpTcFaqAb?;
                if (ppTcFaqAb != null) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 32.0,
                      ),
                      child: HtmlWidget(
                        ppTcFaqAb.ppTcFaqAbDetailsList[0].content,
                      ),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
