import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/progress_dialog.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: FutureBuilder(
        future: _getCurrentLocation(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return ProgressDialog(
              message: "LOADING...",
            );
          }
          Position? position = snapshot.data as Position?;
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target:
                  LatLng(position?.latitude ?? 0.0, position?.longitude ?? 0.0),
              zoom: 16.0,
            ),
            markers: {
              Marker(
                  markerId: MarkerId("1"),
                  position: LatLng(
                      position?.latitude ?? 0.0, position?.longitude ?? 0.0))
            },
            onTap: (latLng) async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newLatLng(latLng));
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        },
      ),
    );
  }
}
