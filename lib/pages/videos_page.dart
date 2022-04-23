import 'dart:core';

import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:url_launcher/url_launcher.dart' as Launcher;

import '../models/VideoInfo.dart';

class VideosPage extends StatelessWidget {
  final List<VideoInfo> videos = [
    VideoInfo(
      videoUrl: "https://www.youtube.com/watch?v=7MFKy7DJsCY",
      coverImage: "assets/images/carousel1.jpg",
      videoTitle: "National Geographic",
      videoDesc:
          "Lost World of the Maya (Full Episode)",
      videoSource: VideoSource.youtube,
    ),
    VideoInfo(
      videoUrl: "https://www.youtube.com/watch?v=WuLevNeUAss",
      coverImage: "assets/images/carousel2.jpg",
      videoTitle: "Harvesting Wild Honey in the Amazon",
      videoDesc:
          "Primal Survivor: Escape the Amazon | National Geographic",
      videoSource: VideoSource.youtube,
    )
  ];

  VideosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: double.infinity,
      height: double.infinity,
      child: GridView.builder(
        itemCount: videos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 3 / 2,
        ),
        itemBuilder: (_, index) => VideoItem(
          videoInfo: videos[index],
        ),
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  final VideoInfo videoInfo;

  const VideoItem({Key? key, required this.videoInfo}) : super(key: key);

  Future<void> _tryLaunchUrl(BuildContext context, String urlString) async {
    if (await Launcher.canLaunch(urlString)) {
      Launcher.launch(urlString);
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: Text("UNABLE TO OPEN"),
          content: Text("Video url is not recognized as valid video url."),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("DISMISS"))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double padding = 8.0;
    double totalWidth = MediaQuery.of(context).size.width - 2 * padding;

    return Card(
      margin: EdgeInsets.zero,
      shadowColor: Colors.black54,
      elevation: 8,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: SizedBox(
                height: totalWidth * 3 / 2,
                width: totalWidth,
                child: GridTile(
                  child: Image.asset(
                    videoInfo.coverImage,
                    fit: BoxFit.cover,
                  ),
                  header: GridTileBar(
                    backgroundColor: Colors.black54,
                    title: Text(
                      videoInfo.videoTitle,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.white, fontSize: 11,
                          ),
                    ),
                    leading: Icon(FaIcon(FontAwesomeIcons.play).icon, size: 9),
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    subtitle: Text(videoInfo.videoDesc ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: Colors.white, fontSize: 9),
                        maxLines: 3),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _tryLaunchUrl(context, videoInfo.videoUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
