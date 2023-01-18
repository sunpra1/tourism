import 'package:flutter/material.dart';
import 'package:tourism/models/my_image.dart';
import 'package:tourism/widgets/my_app_bar.dart';

import '../utils/k.dart';

class ViewImageScreen extends StatefulWidget {
  static const String routeName = "/viewImageScreen";

  const ViewImageScreen({Key? key}) : super(key: key);

  @override
  State<ViewImageScreen> createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  bool showDetails = true;

  void _onImageClick() {
    setState(() {
      showDetails = !showDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    final MyImage image = ModalRoute.of(context)!.settings.arguments as MyImage;

    return Scaffold(
      appBar: MyAppBar(
        backgroundColor: Colors.transparent,
        iconThemeData: IconThemeData(color: Colors.black),
        useDefaultTitle: false,
      ),
      body: Container(
        child: Center(
          child: GestureDetector(
            onTap: _onImageClick,
            child: SizedBox(
              width: double.infinity,
              height: (MediaQuery.of(context).size.width * 2) / 3,
              child: GridTile(
                child: Image.network(
                  "${K.imageBaseUrl}${image.path}",
                  fit: BoxFit.cover,
                ),
                footer: showDetails
                    ? GridTileBar(
                        backgroundColor: Colors.black54,
                        title: Text(
                          image.name,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        subtitle: Text(
                          image.shortDesc,
                          maxLines: 3,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
