class VideoInfo {
  String videoUrl;
  String coverImage;
  String videoTitle;
  String? videoDesc;
  VideoSource videoSource;

  VideoInfo(
      {required this.videoUrl,
      required this.coverImage,
      required this.videoTitle,
      required this.videoDesc,
      required this.videoSource});
}

enum VideoSource { youtube, uploaded }
