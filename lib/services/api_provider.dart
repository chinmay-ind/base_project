import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:base_project/utils/api_path.dart';
import 'package:dio/dio.dart';
import 'custom_exceptions.dart';

class ApiProvider {
  final dio = Dio();

  Future<dynamic> getRequest(
      {required String endpoint, Map<String, dynamic>? queryParams}) async {
    dynamic responseJson;
    try {
      final response =
          await dio.get(baseUrl + endpoint, queryParameters: queryParams);
      responseJson = _parseResponse(endpoint, response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postRequest(
      {required String endpoint, Map<String, dynamic>? body}) async {
    dynamic responseJson;
    try {
      final response = await dio.post(baseUrl + endpoint, data: body);
      responseJson = _parseResponse(endpoint, response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _parseResponse(String url, Response<dynamic> response) {
    log('$url response with Status Code ${response.statusCode},--> ${jsonEncode(response.data)}');
    var result = switch (response.statusCode) {
      200 => response.data,
      (400, 401) => throw BadRequestException(response.data.toString()),
      403 => throw UnauthorisedException(response.data.toString()),
      500 => throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}'),
      _ => throw FetchDataException(
          'Error  occurred while Communication with Server with StatusCode : ${response.statusCode}'),
    };
    return result;
  }
}
