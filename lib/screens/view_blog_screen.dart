import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:tourism/widgets/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart' as Launcher;

import '../models/api_response.dart';
import '../models/blog.dart';
import '../utils/api_request.dart';
import '../widgets/carousel_with_arrow.dart';

class ViewBlogScreen extends StatelessWidget {
  static const String routeName = "/viewBlogScreen";

  const ViewBlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String blogId = ModalRoute.of(context)!.settings.arguments as String;
    Future<Blog?> _getBlog() async {
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

    Future<void> _goToGoogleMap(BuildContext context, Blog blog) async {
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

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder(
          future: _getBlog(),
          builder: (_, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return ProgressDialog(message: "LOADING...", wrap: true);
            }
            Blog? blog = snapshot.data as Blog?;
            if (blog != null) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    snap: false,
                    floating: false,
                    expandedHeight: 250.0,
                    actions: [
                      IconButton(
                        iconSize: 16,
                        icon: Icon(
                          FaIcon(FontAwesomeIcons.map).icon,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () => _goToGoogleMap(context, blog),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        blog.title.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: Colors.white),
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
                          )),
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
