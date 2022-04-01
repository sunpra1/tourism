import 'dart:convert' as Convert;
import 'package:http/http.dart' as Http;
import '../models/api_response.dart';

class APIRequest {
  final String baseUrl = "www.panchpokharitourism.com";
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

  APIRequest({
    required this.requestType,
    required this.requestEndPoint,
    this.queryParameters,
    this.headers,
    this.body,
  });

  T myMethod<T>(T param) {
    return param;
  }

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
    return APIResponse.fromMap(
      Convert.jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}

enum RequestType { get, post, put, patch, delete }

enum RequestEndPoint { register, login }

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
    }
    return value;
  }
}