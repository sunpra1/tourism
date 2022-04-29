import 'package:flutter/material.dart';
import 'package:tourism/models/blog.dart';
import 'package:tourism/models/proximity.dart';
import 'package:tourism/models/proximity_type.dart';
import 'package:tourism/widgets/progress_dialog.dart';

import '../models/api_response.dart';
import '../utils/api_request.dart';
import 'blogs_page.dart';

class ProximityPage extends StatelessWidget {
  final ProximityType proximityType;

  const ProximityPage({Key? key, required this.proximityType})
      : super(key: key);

  Future<Proximity?> _getBlogs(BuildContext context) async {
    APIResponse response = await APIRequest<Map<String, dynamic>>(
        requestType: RequestType.get,
        requestEndPoint: RequestEndPoint.proximity,
        queryParameters: {"type": proximityType.value}).make();
    if (response.success)
      return Proximity.fromMap(response.data);
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.grey.shade300,
      child: FutureBuilder(
        future: _getBlogs(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return ProgressDialog(message: "LOADING...");
          }
          List<Blog> blogs = (snapshot.data as Proximity).list;
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
