// ignore_for_file: file_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<dynamic> responseInterceptor(
    Request request, Response response) async {
  return handelResponse(response);
}

dynamic handelResponse(response) {
  debugPrint('RESPONSE START /////////////////');
  debugPrint('         Status Code: ${response.statusCode}');
  // debugPrint('         Body: ${response.body}');
  debugPrint('RESPONSE END /////////////////');
  return response;
  // switch (response.statusCode) {
  //   case 200:
  //     return response;
  //   default:
  //     showCustomSnackBar(
  //         'Error accrued while fetching data. : ${response.statusCode}');
  //     throw UnknownException(
  //         'Error accrued while fetching data. : ${response.statusCode}');
  // }
}

class AppException implements Exception {
  final int? code;
  final String? message;
  final String? details;

  AppException({this.code, this.message, this.details});

  @override
  String toString() {
    return "[$code]: $message \n $details";
  }
}

class UnknownException extends AppException {
  UnknownException(String message) : super(code: 010, message: message);
}
