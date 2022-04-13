import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
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

    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: FutureBuilder(
            future: _getBlog(),
            builder: (_, snapshot){
              if (snapshot.connectionState != ConnectionState.done) {
                return ProgressDialog(
                    message: "LOADING...", wrap: true);
              }
              Blog? blog = snapshot.data as Blog?;
              if(blog != null) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      snap: false,
                      floating: false,
                      expandedHeight: 250.0,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          blog.title.toUpperCase(),
                          style: Theme
                              .of(context)
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
                                blog.longDes ??
                                    blog.shortDes,
                              ),
                            )
                        ),
                      ),
                    ),
                  ],
                );
              }else{
                return SizedBox.shrink();
              }
            },
          ),
      ),
    );
  }
}
