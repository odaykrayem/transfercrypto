// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/app_constants.dart';
import 'interceptors/RequestInterceptor.dart';
import 'interceptors/ResponseInterceptor.dart';

class ApiClient extends GetConnect implements GetxService {
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late String token;
  final storage = GetStorage();

  ApiClient({
    required this.appBaseUrl,
  }) {
    allowAutoSignedCert = true;

    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 20);
    httpClient.addRequestModifier(requestInterceptor);
    httpClient.addResponseModifier(responseInterceptor);
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
    };
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      // updateHeader(sharedPreferences.getString(AppConstants.token) ?? '');
      updateHeader(storage.read(AppConstants.token) ?? '');

      Response response = await get(uri, headers: headers ?? _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    debugPrint('api Client:$body');
    try {
      Response response = await post(uri, body, headers: _mainHeaders);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
