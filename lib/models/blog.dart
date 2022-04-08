class Blog {
  static const _key_blog_id = "blogId";
  static const _key_title = "title";
  static const _key_sub_title = "subTitle";
  static const _key_short_des = "shortDess";
  static const _key_image = "image";
  static const _key_image1 = "image1";

  final String blogId;
  final String title;
  final String subTitle;
  final String shortDes;
  final String image;
  final String image1;

  Blog({
    required this.blogId,
    required this.title,
    required this.subTitle,
    required this.shortDes,
    required this.image,
    required this.image1,
  });

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      blogId: map[_key_blog_id],
      title: map[_key_title],
      subTitle: map[_key_sub_title],
      shortDes: map[_key_short_des],
      image: map[_key_image],
      image1: map[_key_image1],
    );
  }

  static List<Blog> fromListMap(List<dynamic> listMap) {
    List<Blog> items = [];
    listMap.forEach((element) {
      items.add(Blog.fromMap(element));
    });
    return items;
  }
}
