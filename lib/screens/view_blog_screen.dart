import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tourism/widgets/progress_dialog.dart';

import '../models/api_response.dart';
import '../models/blog.dart';
import '../utils/api_request.dart';
import '../widgets/carousel_with_arrow.dart';

class ViewBlogScreen extends StatelessWidget {
  static const String routeName = "/viewBlogScreen";

  const ViewBlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Blog blog = ModalRoute.of(context)!.settings.arguments as Blog;

    Future<Blog?> _getBlog() async {
      APIResponse response = await APIRequest<Map<String, dynamic>>(
        requestType: RequestType.get,
        requestEndPoint: RequestEndPoint.blog,
      ).make(pathParams: [blog.blogId]);
      if (response.success)
        return Blog.fromMap(response.data);
      else
        return null;
    }

    return Scaffold(
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
                  child: FutureBuilder(
                    future: _getBlog(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return ProgressDialog(
                            message: "LOADING...", wrap: true);
                      }

                      Blog blogWithDetails = snapshot.data as Blog;

                      return SingleChildScrollView(
                        child: Html(
                          data: blogWithDetails.longDes ??
                              blogWithDetails.shortDes,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
