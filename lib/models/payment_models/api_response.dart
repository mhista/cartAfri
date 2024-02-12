class ApiResponse {
  String? message;
  int? statusCode;
  Map<String, dynamic>? data;
  Object? error;
  ApiResponse({
    this.message,
    this.statusCode,
    this.data,
    this.error,
  });

  @override
  String toString() {
    return 'ApiResponse(message: $message, statusCode: $statusCode, data: $data, error: $error)';
  }
}
