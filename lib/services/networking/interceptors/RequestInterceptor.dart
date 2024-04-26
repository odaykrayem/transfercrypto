// ignore_for_file: file_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<Request> requestInterceptor(request) async {
  debugPrint('requestInterceptor START /////////////////');
  debugPrint('               Method: ${request.method}');
  debugPrint('               Url: ${request.url}');
  debugPrint('               Headers: ${request.headers}');
  debugPrint('requestInterceptor END /////////////////');

  return request;
}
