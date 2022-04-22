class DashboardItemInfo {
  static const _key_blog_id = "blogId";
  static const _key_title = "title";
  static const _key_sub_title = "subTitle";
  static const _key_image = "image";
  static const _key_image1 = "image1";

  String blogId;
  String title;
  String subTitle;
  String image;
  String image1;

  DashboardItemInfo(
      {required this.blogId,
      required this.title,
      required this.subTitle,
      required this.image,
      required this.image1});

  factory DashboardItemInfo.fromMap(Map<String, dynamic> map) {
    return DashboardItemInfo(
      blogId: map[_key_blog_id],
      title: map[_key_title],
      subTitle: map[_key_sub_title],
      image: map[_key_image],
      image1: map[_key_image1],
    );
  }

  static List<DashboardItemInfo> fromListMap(List<dynamic> listMap) {
    List<DashboardItemInfo> items = [];
    listMap.forEach((element) {
      items.add(DashboardItemInfo.fromMap(element));
    });
    return items;
  }
}
