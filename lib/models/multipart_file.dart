import 'dart:io';

import 'package:http_parser/http_parser.dart';

class MultipartFile {
  static const String MEDIA_TYPE_IMAGE = "image/*";

  final File file;
  final MediaType mediaType;
  final String fileName;

  MultipartFile(
      {required this.file, required this.mediaType, required this.fileName});
}
