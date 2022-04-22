import 'package:tourism/models/blog.dart';

class Proximity{
  static const _key_list = "list";

  final List<Blog> list;

  const Proximity({required this.list});

  factory Proximity.fromMap(Map<String, dynamic> map){
    return Proximity(list: Blog.fromListMap(map[_key_list]));
  }
}