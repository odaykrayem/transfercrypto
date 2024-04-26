// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:transfercrypto/controllers/home/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/api_constants.dart';
import '../../constants/app_constants.dart';
import '../../models/signup_body_model.dart';
import '../../services/networking/api_client.dart';

class AuthRepo {
  final ApiClient apiClient;
  // final SharedPreferences sharedPreferences;
  final storage = GetStorage();

  AuthRepo({
    required this.apiClient,
    // required this.sharedPreferences,
  });

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(ApiConstants.register, signUpBody.toJson());
  }

  Future<Response> updatePassword(String email, String password) async {
    return await apiClient.postData(ApiConstants.updatePass, {
      'email': email,
      'password': password,
    });
  }

  Future<Response> login(String email, String password) async {
    return await apiClient.post(ApiConstants.login, {
      'email': email,
      'password': password,
    });
  }

  Future<Response> requestOtp(String email) async {
    return await apiClient.post(ApiConstants.requestOTP, {
      'email': email,
    });
  }

  Future<Response> verifyOtp(String email, String otpCode) async {
    return await apiClient.post(ApiConstants.verifyOTP, {
      'email': email,
      'otp': otpCode,
    });
  }

  saveUserTokenAndEmail(String token, String email, String name) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    storage.write(AppConstants.token, token);
    storage.write(AppConstants.email, email);
    storage.write(AppConstants.name, name);
    Get.find<HomeController>().setUserIsLoggedIn(true);

    debugPrint('${Get.find<HomeController>().userLoggedIn}');
    // return await sharedPreferences.setString(, token);
  }

  String getUserToken() {
    // return sharedPreferences.getString(AppConstants.token) ?? 'None';
    return storage.read(AppConstants.token) ?? 'None';
  }

  String getUserEmail() {
    // return sharedPreferences.getString(AppConstants.token) ?? 'None';
    return storage.read(AppConstants.email) ?? 'None';
  }

  String getUserName() {
    // return sharedPreferences.getString(AppConstants.token) ?? 'None';
    return storage.read(AppConstants.name) ?? '';
  }

  bool userLoggedIn() {
    // return sharedPreferences.containsKey(AppConstants.token);
    Get.find<HomeController>().setUserIsLoggedIn(true);

    return storage.read(AppConstants.token) != null;
  }

  // Future<void> saveUserNumberAndPassword(String number, String password) async {
  //   try {
  //     await sharedPreferences.setString(AppConstants.email, number);
  //     await sharedPreferences.setString(AppConstants.password, password);
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  bool clearSavedData() {
    // sharedPreferences.remove(AppConstants.token);
    // sharedPreferences.remove(AppConstants.password);
    // sharedPreferences.remove(AppConstants.email);
    apiClient.token = '';
    apiClient.updateHeader('');
    storage.erase();
    Get.find<HomeController>().setUserIsLoggedIn(false);
    return true;
  }
}
