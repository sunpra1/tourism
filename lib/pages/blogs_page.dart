import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
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
          List<Blog>? blogs = snapshot.data as List<Blog>?;
          return (blogs != null && blogs.length > 0)
              ? ListView.builder(
                  itemBuilder: (_, index) => BlogItem(
                    blog: blogs[index],
                  ),
                  itemCount: blogs.length,
                )
              : Center(
                  child: Text(
                    "NO BLOGS FOUND",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                );
        },
      ),
    );
  }
}

class BlogItem extends StatelessWidget {
  final Blog blog;

  const BlogItem({Key? key, required this.blog}) : super(key: key);

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

  Future<void> _goToGoogleMap(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => ProgressDialog(message: "LOCATING YOU..."));
    Position? position = await _getCurrentLocation(context);
    if (position != null) {
      Uri? url = Uri.tryParse(
          'https://www.google.com/maps/dir/?api=1&origin=${position.latitude},${position.longitude}&destination=${blog.latitude},${blog.longitude}&travelmode=driving&dir_action=navigate');
      if (url != null && await Launcher.canLaunchUrl(url)) {
        await Launcher.launchUrl(url);
      }
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width * 0.25;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 6.0,
        vertical: 3.0,
      ),
      child: Container(
        child: Card(
          shadowColor: Colors.black54,
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ViewBlogScreen.routeName,
                            arguments: blog.blogId);
                      },
                      child: ListTile(
                        tileColor: Colors.white,
                        leading: blog.image == null || blog.image!.isEmpty
                            ? Image.asset(
                                "assets/images/app_logo.png",
                                height: imageSize,
                                width: imageSize,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                "https://${APIRequest.baseUrl}${blog.image}",
                                fit: BoxFit.cover,
                                height: imageSize,
                                width: imageSize,
                                loadingBuilder:
                                    (context, widget, loadingProgress) {
                                  if (loadingProgress == null) return widget;
                                  return Container(
                                    height: imageSize,
                                    width: imageSize,
                                    child: Center(
                                      child: LinearProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
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
                      ),
                    ),
                  ),
                ),
                blog.latitude != null && blog.longitude != null
                    ? Material(
                        child: InkWell(
                          onTap: () => _goToGoogleMap(context),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Center(
                                child: Icon(
                                  FaIcon(FontAwesomeIcons.mapMarker).icon,
                                  size: 12,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          FaIcon(FontAwesomeIcons.chevronRight).icon,
                          size: 12,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
