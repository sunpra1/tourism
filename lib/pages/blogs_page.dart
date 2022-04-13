import 'package:flutter/material.dart';
import 'package:tourism/models/blog.dart';
import 'package:tourism/screens/view_blog_screen.dart';
import 'package:tourism/widgets/progress_dialog.dart';

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
      return Blog.fromListMap(response.data);
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

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width * 0.25;

    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ViewBlogScreen.routeName, arguments: blog.blogId);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 6,
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
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
                            value: loadingProgress.expectedTotalBytes != null
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  subtitle: Text(
                    blog.subTitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
