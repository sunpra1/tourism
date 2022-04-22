import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:tourism/models/menu.dart';

import '../providers/active_drawer_menu_provider.dart';
import '../widgets/progress_dialog.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  Future<LocationData?> _getCurrentLocation(BuildContext context) async {
    Location location = Location();
    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
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
                    context
                        .read<ActiveDrawerMenuProvider>()
                        .activeDrawerMenuType = MenuType.home;
                  },
                  child: Text("OK"))
            ],
          ),
        );
        return null;
      }
    } else if (await location.hasPermission() == PermissionStatus.denied) {
      if (await location.requestPermission() == PermissionStatus.denied) {
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
                    context
                        .read<ActiveDrawerMenuProvider>()
                        .activeDrawerMenuType = MenuType.home;
                  },
                  child: Text("OK"))
            ],
          ),
        );
        return null;
      }
    }
    return await location.getLocation();
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
          LocationData? location = snapshot.data as LocationData?;
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target:
                  LatLng(location?.latitude ?? 0.0, location?.longitude ?? 0.0),
              zoom: 16.0,
            ),
            markers: {
              Marker(
                  markerId: MarkerId("1"),
                  position: LatLng(
                      location?.latitude ?? 0.0, location?.longitude ?? 0.0))
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
