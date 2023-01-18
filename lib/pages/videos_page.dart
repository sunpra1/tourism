import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:tourism/data/api_service.dart';
import 'package:tourism/data/pojo/videos_detail_response.dart';
import 'package:tourism/models/video_detail.dart';
import 'package:tourism/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart' as Launcher;

import '../widgets/progress_dialog.dart';

class VideosPage extends StatelessWidget {
  Future<List<VideoDetail>?> _getVideos(BuildContext context) async {
    try {
      VideosDetailResponse videoDetailResponse =
          await APIService(Utils.getDioWithInterceptor()).getVideos({
        "value": "",
        "category": "",
        "subCategory": "",
        "location": "",
        "page": 1,
        "pageSize": 30,
        "totalPage": 1,
      });
      if (videoDetailResponse.success)
        return videoDetailResponse.data;
      else
        return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  VideosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder(
        future: _getVideos(context),
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return ProgressDialog(message: "LOADING...");
          }

          List<VideoDetail>? videos = snapshot.data as List<VideoDetail>?;

          return (videos != null && videos.length > 0)
              ? GridView.builder(
                  itemCount: videos.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 3 / 2,
                  ),
                  itemBuilder: (_, index) => VideoItem(
                    key: Key(videos[index].id.toString()),
                    videoDetail: videos[index],
                  ),
                )
              : Center(
                  child: Text(
                    "NO VIDEOS AVAILABLE",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                );
        },
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  final VideoDetail videoDetail;

  const VideoItem({Key? key, required this.videoDetail}) : super(key: key);

  Future<void> _tryLaunchUrl(BuildContext context, String urlString) async {
    Uri? uri = Uri.tryParse(urlString);
    if (uri != null && await Launcher.canLaunchUrl(uri)) {
      Launcher.launchUrl(uri);
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

  String? _getVideoIdFromYoutubeUrl(String? url) {
    if (url == null) return null;
    Uri videoUri = Uri.parse(url);
    return videoUri.queryParameters["v"];
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
                  child: videoDetail.imagePath != null
                      ? Image.network(
                          videoDetail.imagePath!,
                          fit: BoxFit.cover,
                        )
                      : _getVideoIdFromYoutubeUrl(videoDetail.path) != null
                          ? Image.network(
                              "https://img.youtube.com/vi/${_getVideoIdFromYoutubeUrl(videoDetail.path)}/hqdefault.jpg",
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/images/youtube.jpeg",
                              fit: BoxFit.cover,
                            ),
                  header: GridTileBar(
                    backgroundColor: Colors.black54,
                    title: Text(
                      videoDetail.name,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                      maxLines: 3,
                    ),
                    leading: Icon(FaIcon(FontAwesomeIcons.play).icon, size: 9),
                  ),
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    subtitle: Text(videoDetail.shortDec,
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
                onTap: () => _tryLaunchUrl(context, videoDetail.path),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
