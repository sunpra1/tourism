import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class FailedGettingData extends StatefulWidget {
  final Function() onClick;

  const FailedGettingData({Key? key, required this.onClick}) : super(key: key);

  @override
  State<FailedGettingData> createState() => _FailedGettingDataState();
}

class _FailedGettingDataState extends State<FailedGettingData> {
  ConnectivityResult? connectivityResult;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on Exception {
      return Future.value(null);
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      connectivityResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              connectivityResult == ConnectivityResult.none
                  ? "assets/images/no_internet_connection.webp"
                  : "assets/images/server_maintenance.webp",
              width: 200.0,
              height: 220.0,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              connectivityResult == ConnectivityResult.none
                  ? "No Internet Connection"
                  : "Unable to get data from server.",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              connectivityResult == ConnectivityResult.none
                  ? "Check your connection, then refresh the page."
                  : "Please, try again sometime later.",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.black..withOpacity(0.6)),
            ),
            SizedBox(
              height: 24,
            ),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              onPressed: widget.onClick,
              child: Text(
                connectivityResult == ConnectivityResult.none
                    ? "Refresh"
                    : "Retry",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
