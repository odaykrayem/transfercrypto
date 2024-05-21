// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../constants/api_constants.dart';
import '../../services/networking/api_client.dart';

class TransferRepo extends GetxService {
  final ApiClient apiClient;

  TransferRepo({
    required this.apiClient,
  });

  Future<Response> getTransferMethodsValuesList() async {
    return await apiClient.getData(ApiConstants.getTransferMethodsValuesList);
  }

  Future<Response> addTransaction({
    required Map<String, dynamic> data,
    required Uint8List? receiptimageData,
    required Uint8List? codeImageData,
  }) async {
    late Map<String, dynamic> allData;

    if (receiptimageData != null) {
      try {
        String base64Image = base64Encode(receiptimageData);
        Map<String, dynamic> newData = {
          'user_image': base64Image,
        };

        newData.addAll(data);
        allData = {}
          ..addAll(newData)
          ..addAll(data);
      } catch (e) {
        debugPrint('transaction repo catch 1');

        e.printError();
      }
    } else if (codeImageData != null) {
      debugPrint('upload Image 2');
      try {
        String base64Image = base64Encode(codeImageData);
        Map<String, dynamic> newData = {
          'user_op_image': base64Image,
        };

        newData.addAll(data);
        allData = {}
          ..addAll(newData)
          ..addAll(data);
      } catch (e) {
        debugPrint('transaction repo catch 1');

        e.printError();
      }
    } else {
      allData = {}..addAll(data);
    }

    late Response response;
    try {
      return await apiClient.postData(ApiConstants.addTransaction, allData);
    } catch (e) {
      debugPrint('transaction repo catch 2');
      e.printError();
    }
    response = Response(statusCode: 432);
    return response;
  }

  Future<Response> addWTC(Map<String, dynamic> data) async {
    return await apiClient.postData(ApiConstants.addWalletToCash, data);
  }

  Future<Response> addCTW(
      Map<String, dynamic> data, File image, Uint8List receiptimageData) async {
    late Map<String, dynamic> allData;
    try {
      String base64Image = base64Encode(receiptimageData);

      debugPrint('ctw repo catch1');
      Map<String, dynamic> newData = {
        'user_receipt_image': base64Image,
      };

      newData.addAll(data);
      allData = {}
        ..addAll(newData)
        ..addAll(data);
    } catch (e) {
      debugPrint('ctw repo catch');

      e.printError();
    }
    late Response response;
    try {
      return await apiClient.postData(ApiConstants.addCashToWallet, allData);
    } catch (e) {
      debugPrint('ctw repo catch 2');
      e.printError();
    }
    response = Response(statusCode: 432);
    return response;
  }

  Future<Response> addWTW(Map<String, dynamic> data) async {
    return await apiClient.postData(ApiConstants.addWalletToWallet, data);
  }
}
