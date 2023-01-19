import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:tourism/data/api_service.dart';
import 'package:tourism/data/pojo/app_details_body.dart';
import 'package:tourism/data/pojo/pp_tc_faq_ab_response.dart';
import 'package:tourism/models/menu.dart';
import 'package:tourism/models/pp_tc_faq_ab.dart';
import 'package:tourism/utils/app_theme.dart';

import '../utils/utils.dart';
import '../widgets/progress_dialog.dart';
import 'failed_getting_data_page.dart';

class ApplicationDetails extends StatefulWidget {
  final MenuType drawerMenuType;

  const ApplicationDetails({Key? key, required this.drawerMenuType})
      : super(key: key);

  @override
  State<ApplicationDetails> createState() => _ApplicationDetailsState();
}

class _ApplicationDetailsState extends State<ApplicationDetails> {
  Future<PpTcFaqAb?> _getPpTcFaqAb(BuildContext context) async {
    FlagType flagType;
    switch (widget.drawerMenuType) {
      case MenuType.aboutUs:
        flagType = FlagType.aboutUS;
        break;
      case MenuType.privacyPolicy:
        flagType = FlagType.privacyPolicy;
        break;
      default:
        flagType = FlagType.termsAndCondition;
        break;
    }
    try {
      PpTcFaqAbResponse ppTcFaqAbResponse =
          await APIService(Utils.getDioWithInterceptor())
              .getAppDetails(AppDetailsBody(flag: flagType).toJson());
      if (ppTcFaqAbResponse.success) {
        return ppTcFaqAbResponse.data;
      } else
        throw Exception();
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  _retry() => setState(() {});

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
                widget.drawerMenuType.value.toUpperCase(),
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
            child: FutureBuilder<PpTcFaqAb?>(
              future: _getPpTcFaqAb(context),
              builder: (_, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return ProgressDialog(
                    message: "LOADING...",
                    wrap: true,
                  );
                }
                PpTcFaqAb? ppTcFaqAb = snapshot.data;

                if (ppTcFaqAb == null) {
                  return FailedGettingData(
                    onClick: _retry,
                  );
                }

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
              },
            ),
          ),
        ],
      ),
    );
  }
}
