import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tourism/data/api_service.dart';
import 'package:tourism/screens/view_image_screen.dart';
import 'package:tourism/utils/utils.dart';

import '../data/pojo/my_images_response.dart';
import '../models/my_image.dart';
import '../utils/k.dart';
import '../widgets/progress_dialog.dart';
import 'failed_getting_data_page.dart';
import 'feels_lonely_here_page.dart';

class ImagesPage extends StatefulWidget {
  const ImagesPage({Key? key}) : super(key: key);

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  Future<List<MyImage>?> _getImages(BuildContext context) async {
    try {
      MyImagesResponse myImageResponse =
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

  _retry() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder<List<MyImage>?>(
        future: _getImages(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return ProgressDialog(message: "LOADING...");
          }

          List<MyImage>? images = snapshot.data;

          if (images == null) {
            return FailedGettingData(
              onClick: _retry,
            );
          }

          if (images.isEmpty) {
            return FeelsLonelyHerePage(message: "No images available.");
          }

          return GridView.builder(
            itemCount: images.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemBuilder: (_, index) => ImageItem(image: images[index]),
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
            "${K.imageBaseUrl}${image.path}",
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
