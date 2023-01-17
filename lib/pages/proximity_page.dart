import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tourism/data/pojo/nearby_places_response.dart';
import 'package:tourism/models/blog.dart';
import 'package:tourism/models/proximity.dart';
import 'package:tourism/models/proximity_type.dart';
import 'package:tourism/widgets/progress_dialog.dart';

import '../data/api_service.dart';
import '../utils/utils.dart';
import 'blogs_page.dart';

class ProximityPage extends StatelessWidget {
  final ProximityType proximityType;

  const ProximityPage({Key? key, required this.proximityType})
      : super(key: key);

  Future<Proximity?> _getBlogs(BuildContext context) async {
    try {
      NearbyPlacesResponse nearbyPlacesResponse =
          await APIService(Utils.getDioWithInterceptor()).getNearbyPlaces();
      if (nearbyPlacesResponse.success)
        return nearbyPlacesResponse.data;
      else
        return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.grey.shade300,
      child: FutureBuilder<Proximity?>(
        future: _getBlogs(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return ProgressDialog(message: "LOADING...");
          }
          List<Blog>? blogs = snapshot.data?.list;

          if (blogs == null) {
            return ProgressDialog(message: "LOADING...");
          }

          return ListView.builder(
            itemBuilder: (_, index) => BlogItem(
              blog: blogs[index],
            ),
            itemCount: blogs.length,
          );
        },
      ),
    );
  }
}
