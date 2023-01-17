import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tourism/data/api_service.dart';
import 'package:tourism/screens/view_image_screen.dart';
import 'package:tourism/utils/utils.dart';

import '../data/pojo/my_image_response.dart';
import '../models/my_image.dart';
import '../utils/api_request.dart';
import '../widgets/progress_dialog.dart';

class ImagesPage extends StatelessWidget {
  const ImagesPage({Key? key}) : super(key: key);

  Future<List<MyImage>?> _getImages(BuildContext context) async {
    try {
      MyImageResponse myImageResponse =
          await APIService(Utils.getDioWithInterceptor()).getImages();
      if (myImageResponse.success)
        return myImageResponse.data;
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
      padding: EdgeInsets.all(8.0),
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder(
        future: _getImages(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return ProgressDialog(message: "LOADING...");
          }
          List<MyImage>? images = snapshot.data as List<MyImage>?;
          return (images != null && images.length > 0)
              ? GridView.builder(
                  itemCount: images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemBuilder: (_, index) => ImageItem(image: images[index]),
                )
              : Center(
                  child: Text(
                    "NO IMAGES FOUND",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                );
        },
      ),
    );
  }
}

class ImageItem extends StatelessWidget {
  final MyImage image;

  const ImageItem({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            "https://${APIRequest.baseUrl}${image.path}",
            fit: BoxFit.cover,
            loadingBuilder: (context, widget, loadingProgress) {
              if (loadingProgress == null) return widget;
              return Center(
                child: LinearProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(ViewImageScreen.routeName, arguments: image);
              },
            ),
          ),
        ),
      ],
    );
  }
}
