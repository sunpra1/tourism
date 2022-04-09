import 'dart:convert' as Convert;

import 'package:http/http.dart' as Http;
import 'package:tourism/models/multipart_file.dart';

import '../models/api_response.dart';

class APIRequest<T> {
  static String baseUrl = "www.panchpokharitourism.com";
  static const String _contentType = "Content-Type";
  static const String _contentTypeValue = "application/json; charset=utf-8";

  RequestType requestType;
  RequestEndPoint requestEndPoint;
  Map<String, dynamic>? queryParameters;
  final Map<String, String> _requiredHeaders = const {
    _contentType: _contentTypeValue
  };
  Map<String, String>? headers;
  Map<String, dynamic>? body;
  List<MultipartFile>? multipartFiles;

  APIRequest(
      {required this.requestType,
      required this.requestEndPoint,
      this.queryParameters,
      this.headers,
      this.body,
      this.multipartFiles});

  Future<APIResponse> make() async {
    Uri uri = Uri.http(baseUrl, requestEndPoint.value, queryParameters);
    Http.Response response;
    if (headers != null) _requiredHeaders.addAll(headers!);
    switch (requestType) {
      case RequestType.get:
        response = await Http.get(uri, headers: _requiredHeaders);
        break;
      case RequestType.post:
        response = await Http.post(uri,
            headers: _requiredHeaders, body: Convert.jsonEncode(body));
        break;
      case RequestType.put:
        response = await Http.put(uri,
            headers: _requiredHeaders, body: Convert.jsonEncode(body));
        break;
      case RequestType.patch:
        response = await Http.patch(uri,
            headers: _requiredHeaders, body: Convert.jsonEncode(body));
        break;
      case RequestType.delete:
        response = await Http.delete(uri,
            headers: _requiredHeaders, body: Convert.jsonEncode(body));
        break;
    }
    print("Response ${response.body}");
    return APIResponse<T>.fromMap(
      Convert.jsonDecode(response.body),
    );
  }

  Future<APIResponse> makeMultipart() async {
    Uri uri = Uri.http(baseUrl, requestEndPoint.value, queryParameters);
    Http.MultipartRequest request =
        new Http.MultipartRequest(requestType.value, uri);
    if (headers != null) _requiredHeaders.addAll(headers!);
    request.headers.addAll(_requiredHeaders);
    body?.entries.map((e) {
      request.fields[e.key] = e.value;
    });

    multipartFiles?.map((e) async {
      request.files.add(
        new Http.MultipartFile.fromBytes(
          e.fileName,
          await e.file.readAsBytes(),
          contentType: e.mediaType,
        ),
      );
    });
    Http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    print("Multipart Response: $responseString");
    return APIResponse<T>.fromMap(
      Convert.jsonDecode(responseString),
    );
  }
}

enum RequestType { get, post, put, patch, delete }

extension RequestTypeExt on RequestType {
  String get value {
    String value;
    switch (this) {
      case RequestType.put:
        value = "PUT";
        break;
      case RequestType.patch:
        value = "PATCH";
        break;
      default:
        value = "POST";
        break;
    }
    return value;
  }
}

enum RequestEndPoint { register, login, blog, images, updateProfile }

extension RequestEndPointExt on RequestEndPoint {
  String get value {
    String value;
    switch (this) {
      case RequestEndPoint.register:
        value = "/api/Account/Register";
        break;
      case RequestEndPoint.login:
        value = "/api/Account/Login";
        break;
      case RequestEndPoint.blog:
        value = "/api/Blog/GetAllBlog";
        break;
      case RequestEndPoint.images:
        value = "/api/ImageVideo/GetAllImageList";
        break;
      case RequestEndPoint.updateProfile:
        value = "/api/UserProfile/SaveUpdateUserProfile";
        break;
    }
    return value;
  }
}
