import 'package:flutter/material.dart';

import '../models/blog.dart';
import '../widgets/carousel_with_arrow.dart';

class ViewBlogScreen extends StatelessWidget {
  static const String routeName = "/viewBlogScreen";

  const ViewBlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Blog blog = ModalRoute.of(context)!.settings.arguments as Blog;

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
                height: MediaQuery.of(context).size.height - 75,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 32.0,
                  ),
                  child: Text(
                    blog.shortDes,
                    style: Theme.of(context).textTheme.labelMedium,
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
