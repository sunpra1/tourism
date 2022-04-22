import 'package:flutter/material.dart';
import 'package:tourism/utils/api_request.dart';

class CarouselWithArrow extends StatefulWidget {
  final List<String> images;

  const CarouselWithArrow({Key? key, required this.images}) : super(key: key);

  @override
  State<CarouselWithArrow> createState() => _CarouselWithArrowState();
}

class _CarouselWithArrowState extends State<CarouselWithArrow> {
  int currentPageIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = widget.images;

    return Container(
      height: 250,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 8,
        shadowColor: Colors.black,
        child: Stack(
          children: [
            PageView.builder(
              onPageChanged: _onPageChanged,
              pageSnapping: true,
              itemBuilder: (_, index) => CarouselItem(image: images[index]),
              itemCount: images.length,
              scrollDirection: Axis.horizontal,
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 24,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Icon(
                        currentPageIndex > 0 ? Icons.arrow_back_ios : null,
                        color: Colors.red,
                      ),
                      Spacer(),
                      Icon(
                        (currentPageIndex < images.length - 1)
                            ? Icons.arrow_forward_ios_rounded
                            : null,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CarouselItem extends StatelessWidget {
  final String image;

  const CarouselItem({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://${APIRequest.baseUrl}/$image",
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
      loadingBuilder: (context, widget, loadingProgress) {
        if (loadingProgress == null) return widget;
        return Center(
          child: SizedBox(
            height: 64,
            width: 64,
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
    );
  }
}
