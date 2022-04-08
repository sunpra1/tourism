class MyImage {
  static const _key_image_id = "imageVideId";
  static const _key_name = "name";
  static const _key_path = "path";
  static const _key_short_desc = "shortDesc";
  static const _key_display_order = "displayOrder";

  int imageId;
  String name;
  String path;
  String shortDesc;
  int displayOrder;

  MyImage({
    required this.imageId,
    required this.name,
    required this.path,
    required this.shortDesc,
    required this.displayOrder,
  });

  factory MyImage.fromMap(Map<String, dynamic> map) {
    return MyImage(
      imageId: map[_key_image_id],
      name: map[_key_name],
      path: map[_key_path],
      shortDesc: map[_key_short_desc],
      displayOrder: map[_key_display_order],
    );
  }

  static List<MyImage> fromListMap(List<dynamic> listMap) {
    List<MyImage> items = [];
    listMap.forEach((element) {
      items.add(MyImage.fromMap(element));
    });
    return items;
  }
}
