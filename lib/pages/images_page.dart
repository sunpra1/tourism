import 'package:flutter/material.dart';
import 'package:tourism/screens/view_image_screen.dart';

import '../models/api_response.dart';
import '../models/my_image.dart';
import '../utils/api_request.dart';
import '../widgets/progress_dialog.dart';

class ImagesPage extends StatelessWidget {
  const ImagesPage({Key? key}) : super(key: key);

  Future<List<MyImage>?> _getImages(BuildContext context) async {
    APIResponse response = await APIRequest<List<dynamic>>(
        requestType: RequestType.post,
        requestEndPoint: RequestEndPoint.images,
        body: {}).make();
    if (response.success)
      return MyImage.fromListMap(response.data);
    else
      return null;
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
          List<MyImage> images = snapshot.data as List<MyImage>;
          return GridView.builder(
            itemCount: images.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemBuilder: (_, index) => Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    "https://${APIRequest.baseUrl}/${images[index].path}",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ViewImageScreen.routeName,
                            arguments: images[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
