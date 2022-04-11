import 'dart:core';

import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import '../models/VideoInfo.dart';
import 'package:url_launcher/url_launcher.dart' as Launcher;

class VideosPage extends StatelessWidget {
  final List<VideoInfo> videos = [
    VideoInfo(
      videoUrl: "https://www.youtube.com/watch?v=yhbVFtaBmso",
      coverImage: "assets/images/carousel1.jpg",
      videoTitle: "Mujhko Kya Hua Hai",
      videoDesc:
          "Unplugged Version of Kuch Kuch Hota Hai's Mujhko Kya Hua Hai by Karan Nawani.",
      videoSource: VideoSource.youtube,
    ),
    VideoInfo(
      videoUrl: "https://www.youtube.com/watch?v=FlY2YplRQMM",
      coverImage: "assets/images/carousel2.jpg",
      videoTitle: "Aashiyan",
      videoDesc:
          "Bari's movie Aashiyan song. It is sung by Pritam da and Nikhil Paul.",
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

  Future<void> _tryLaunchUrl(BuildContext context, String urlString) async{
    if(await Launcher.canLaunch(urlString)){
      Launcher.launch(urlString);
    }else{
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

    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: totalWidth * 3 / 2,
                width: totalWidth,
                child: GridTile(
                  child: Image.asset(videoInfo.coverImage, fit: BoxFit.cover,),
                  header: GridTileBar(
                    backgroundColor: Colors.black54,
                    title: Text(
                      videoInfo.videoTitle,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    leading: Icon(FaIcon(FontAwesomeIcons.play).icon, size: 18),
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    subtitle: Text(videoInfo.videoDesc ?? "",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontSize: 9
                            ),
                        maxLines: 3),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: ()  => _tryLaunchUrl(context, videoInfo.videoUrl),
            ),
          ),
        ),
      ],
    );
  }
}
