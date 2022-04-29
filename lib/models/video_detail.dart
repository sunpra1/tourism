class VideoDetail {
  static const String _key_video_id = "imageVideId";
  static const String _key_name = "name";
  static const String _key_path = "path";
  static const String _key_image_path = "imagePath";
  static const String _key_short_desc = "shortDesc";
  static const String _key_display_order = "displayOrder";

  final int id;
  final String name;
  final String path;
  final String? imagePath;
  final String shortDec;
  final int displayOrder;

  const VideoDetail({
    required this.id,
    required this.name,
    required this.path,
    required this.imagePath,
    required this.shortDec,
    required this.displayOrder,
  });

  factory VideoDetail.fromMap(Map<String, dynamic> map) {
    return VideoDetail(
      id: map[_key_video_id],
      name: map[_key_name],
      path: map[_key_path],
      imagePath: map[_key_image_path],
      shortDec: map[_key_short_desc],
      displayOrder: map[_key_display_order],
    );
  }

  static List<VideoDetail> fromListMap(List<dynamic> listMap) {
    List<VideoDetail> items = [];
    listMap.forEach((element) {
      items.add(VideoDetail.fromMap(element));
    });
    return items;
  }
}
