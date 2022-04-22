import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:tourism/models/blog.dart';
import 'package:tourism/screens/view_blog_screen.dart';
import 'package:tourism/widgets/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart' as Launcher;

import '../models/api_response.dart';
import '../utils/api_request.dart';

class BlogsPage extends StatelessWidget {
  const BlogsPage({Key? key}) : super(key: key);

  Future<List<Blog>?> _getBlogs(BuildContext context) async {
    APIResponse response = await APIRequest<List<dynamic>>(
        requestType: RequestType.post,
        requestEndPoint: RequestEndPoint.blogs,
        body: {}).make();
    if (response.success)
      return Blog.fromListMap(response.data)
          .where((element) =>
              element.latitude == null || element.longitude == null)
          .toList();
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
          List<Blog> blogs = snapshot.data as List<Blog>;
          return ListView.builder(
            itemBuilder: (_, index) => BlogItem(
              blog: blogs[index],
            ),
            itemCount: (snapshot.data as List<Blog>?)?.length ?? 0,
          );
        },
      ),
    );
  }
}

class BlogItem extends StatelessWidget {
  final Blog blog;

  const BlogItem({Key? key, required this.blog}) : super(key: key);

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

  Future<void> _goToGoogleMap(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => ProgressDialog(message: "LOCATING YOU..."));
    LocationData? location = await _getCurrentLocation(context);
    if (location != null) {
      String url =
          'https://www.google.com/maps/dir/?api=1&origin=${location.latitude},${location.longitude}&destination=${blog.latitude},${blog.longitude}&travelmode=driving&dir_action=navigate';
      print(url);
      if (await Launcher.canLaunch(url)) {
        await Launcher.launch(url);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width * 0.25;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 6,
      ),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Material(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(ViewBlogScreen.routeName,
                      arguments: blog.blogId);
                },
                child: Container(
                  child: Column(
                    children: [
                      ListTile(
                        tileColor: Colors.white,
                        leading: Image.network(
                          "https://${APIRequest.baseUrl}/${blog.image}",
                          fit: BoxFit.cover,
                          height: imageSize,
                          width: imageSize,
                          loadingBuilder: (context, widget, loadingProgress) {
                            if (loadingProgress == null) return widget;
                            return Container(
                              height: imageSize,
                              width: imageSize,
                              child: Center(
                                child: LinearProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                        title: Text(
                          blog.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        subtitle: Text(
                          blog.subTitle,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  color: Colors.grey.shade600, fontSize: 12),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (blog.latitude != null && blog.longitude != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: TextButton(
                  onPressed: () => _goToGoogleMap(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                        ),
                        child: Text(
                          "GET DIRECTION",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      Icon(
                        FaIcon(FontAwesomeIcons.map).icon,
                        size: 12,
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
