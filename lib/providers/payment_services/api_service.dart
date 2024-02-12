import 'dart:convert';

import 'package:cartafri/features/payment/payment_models/api_response.dart';
import 'package:cartafri/features/payment/paystack/keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider((ref) => ApiService());

class ApiService {
  final Dio _dio = Dio();
  BaseOptions options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 50000),
      receiveTimeout: const Duration(milliseconds: 50000),
      headers: {
        "Accept": "application/json",
        "content-Type": "application/json",
        "Authorization": "Bearer ${SecretKey.secretKey}"
      });

  ApiService() {
    _dio.options = options;
  }

  Future<ApiResponse> post(
      {required String url, FormData? formData, String? data}) async {
    _dio.options = options;
    Response response;
    final ApiResponse apiResponse = ApiResponse();
    try {
      response = await _dio.post(
        url,
        data: formData ?? data,
      );
      final raw = jsonDecode(jsonEncode(response.data));
      apiResponse.data = raw["data"] ?? raw;
      apiResponse.statusCode = response.statusCode;
    } on DioException catch (e) {
      apiResponse.error = {"message": e.response?.statusMessage};
      apiResponse.statusCode = e.response?.statusCode;
    } catch (e) {
      apiResponse.error = {"message": "unknown error"};
      apiResponse.statusCode = null;
    }
    return apiResponse;
  }

  Future<ApiResponse> put(
      {required String url, FormData? formData, String? data}) async {
    _dio.options = options;
    Response response;
    final ApiResponse apiResponse = ApiResponse();
    try {
      response = await _dio.put(
        url,
        data: formData ?? data,
      );
      final raw = jsonDecode(jsonEncode(response.data));
      apiResponse.data = raw["data"] ?? raw;
      apiResponse.statusCode = response.statusCode;
    } on DioException catch (e) {
      apiResponse.error = {"message": e.response?.data};
      apiResponse.statusCode = e.response?.statusCode;
    } catch (e) {
      apiResponse.error = {"message": "unknown error"};
      apiResponse.statusCode = null;
    }
    return apiResponse;
  }

  Future<ApiResponse> get(
      {required String url,
      Map<String, dynamic> mapValue = const <String, dynamic>{}}) async {
    _dio.options = options;
    Response response;
    final ApiResponse apiResponse = ApiResponse();
    try {
      response = await _dio.get(
        url,
        queryParameters: mapValue,
      );
      final raw = jsonDecode(jsonEncode(response.data));
      apiResponse.data = raw["data"] ?? raw;
      apiResponse.statusCode = response.statusCode;
    } on DioException catch (e) {
      apiResponse.error = {"message": e.response?.data};
      apiResponse.statusCode = e.response?.statusCode;
    } catch (e) {
      apiResponse.error = {"message": "unknown error"};
      apiResponse.statusCode = null;
    }
    return apiResponse;
  }
}
