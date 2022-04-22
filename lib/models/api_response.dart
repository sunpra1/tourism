class APIResponse<T> {
  static const String _key_code = "code";
  static const String _key_success = "success";
  static const String _key_message = "message";
  static const String _key_data = "data";

  int code;
  bool success;
  String? message;
  T? data;

  APIResponse({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  factory APIResponse.fromMap(Map<String, dynamic> map) {
    return APIResponse(
      code: int.parse(map[_key_code]),
      success: map[_key_success] as bool,
      message: map[_key_message],
      data: map[_key_data] as T?,
    );
  }
}
