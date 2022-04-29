import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tourism/widgets/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart' as Launcher;

import '../models/api_response.dart';
import '../models/blog.dart';
import '../utils/api_request.dart';
import '../widgets/carousel_with_arrow.dart';

class ViewBlogScreen extends StatelessWidget {
  static const String routeName = "/viewBlogScreen";

  const ViewBlogScreen({Key? key}) : super(key: key);

  Future<Blog?> _getBlog(BuildContext context) async {
    final String blogId = ModalRoute.of(context)!.settings.arguments as String;
    try {
      APIResponse response = await APIRequest<Map<String, dynamic>>(
        requestType: RequestType.get,
        requestEndPoint: RequestEndPoint.blog,
      ).make(pathParams: [blogId]);
      if (response.success)
        return Blog.fromMap(response.data);
      else
        throw Exception();
    } on Exception catch (_) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: Text("ERROR"),
          content: Text("Unable to load blog details."),
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

  Future<void> _goToGoogleMap(BuildContext context, Blog blog) async {
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
    return FutureBuilder(
      future: _getBlog(context),
      builder: (_, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: ProgressDialog(message: "LOADING...", wrap: false),
          );
        }
        Blog? blog = snapshot.data as Blog?;
        return blog != null
            ? Scaffold(
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        snap: false,
                        floating: false,
                        expandedHeight: 250.0,
                        actions: [
                          if (blog.latitude != null && blog.longitude != null)
                            FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: InkWell(
                                    onTap: () => _goToGoogleMap(context, blog),
                                    child: Center(
                                      child: Icon(
                                        FaIcon(FontAwesomeIcons.mapMarker).icon,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: 8,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          title: FittedBox(
                            child: Text(
                              blog.title.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                          centerTitle: false,
                          background: CarouselWithArrow(
                            images: [blog.image, blog.image1],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 32.0,
                            ),
                            child: SingleChildScrollView(
                              child: HtmlWidget(
                                blog.longDes ?? blog.shortDes,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox.shrink();
      },
    );
  }
}
