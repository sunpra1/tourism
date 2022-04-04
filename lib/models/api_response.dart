class APIResponse<T> {
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
      code: int.parse(map["code"]),
      success: map["success"] as bool,
      message: map["message"],
      data: map["data"] as T?,
    );
  }
}
