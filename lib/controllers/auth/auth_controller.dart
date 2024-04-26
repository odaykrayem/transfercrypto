// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../data/repository/auth_repo.dart';
import '../../models/response_model.dart';
import '../../models/signup_body_model.dart';
import '../../services/networking/print_response_info.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late SignUpBody _signUpBody;
  SignUpBody get signUpBody => _signUpBody;
  // late UpdatePassBody _updatePassBody;
  // UpdatePassBody get updatePassBody => _updatePassBody;
  final storage = GetStorage();

  AuthController({
    required this.authRepo,
  });

  @override
  void onInit() {
    super.onInit();
  }

  void setIsLoading(bool i) {
    _isLoading = i;
    update();
  }

  void setSignupBody(SignUpBody signUpBody) {
    _signUpBody = signUpBody;
  }

  // void setUpdatePassBody(UpdatePassBody updatePassBody) {
  //   _updatePassBody = updatePassBody;
  // }

  Future<ResponseModel> register() async {
    _isLoading = true;
    late ResponseModel responseModel;
    update();
    if (_signUpBody == null) {
      responseModel = ResponseModel(false, 'Error saving data');
    } else {
      try {
        Response response = await authRepo.registration(_signUpBody);
        if (response.statusCode == 200) {
          // authRepo.saveUserToken(response.body['data']['token']);
          responseModel = ResponseModel(true, response.body['data']['token']);
        } else {
          printResponseInfo(response, "Register");
          if ((response.body['errors']) != null) {
            responseModel = ResponseModel(
                false, '${(response.body['errors'])[0]['message']}');
          } else {
            responseModel = ResponseModel(false, 'error');
          }
        }
      } catch (e) {
        responseModel = ResponseModel(false, e.toString());
        e.printError();
        _isLoading = false;
        update();
      }
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    update();
    late ResponseModel responseModel;
    try {
      Response response = await authRepo.login(email, password);

      if (response.statusCode == 200) {
        authRepo.saveUserTokenAndEmail(
            response.body['data']['token'],
            response.body['data']['email'],
            '${response.body['data']['f_name']}  ${response.body['data']['l_name']}');
        // debugPrint('${authRepo.getUserToken()}');
        // UserModel userModel = UserModel.fromJson(response.body['data']);
        // debugPrint('user :' + userModel.toString());
        // CacheHelper.saveData(
        //     key: AppConstants.USER_DATA_KEY,
        //     value: jsonEncode(userModel.toJson()));
        // UserModel user2 = UserModel.fromJson(
        //     jsonDecode(CacheHelper.getData(key: AppConstants.USER_DATA_KEY)));
        // debugPrint('userAfter :  ${user2.toJson()}');
        responseModel = ResponseModel(true, response.body['data']['token']);
        responseModel = ResponseModel(true, 'loggedInSuccessfully'.tr);
      } else {
        // printResponseInfo(response, "Login Error");
        debugPrint('${response.body}');
        responseModel = ResponseModel(false, response.body['msg']);
      }
    } catch (e) {
      e.printError();
      responseModel = ResponseModel(false, 'someErrorHappened');
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> requestOtp(String email) async {
    _isLoading = true;
    update();
    late ResponseModel responseModel;
    try {
      Response response = await authRepo.requestOtp(email);

      if (response.statusCode == 200) {
        responseModel = ResponseModel(true, 'otpSentSuccessfully'.tr);
      } else {
        debugPrint('${response.body}');
        responseModel = ResponseModel(false, response.body['msg']);
      }
    } catch (e) {
      e.printError();
      responseModel = ResponseModel(false, 'someErrorHappened');
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> verifyOTP(String email, String otp) async {
    _isLoading = true;
    update();
    late ResponseModel responseModel;
    try {
      Response response = await authRepo.verifyOtp(email, otp);

      if (response.statusCode == 200) {
        responseModel = ResponseModel(true, 'otp verified successfully'.tr);
      } else {
        debugPrint('${response.body}');
        responseModel = ResponseModel(false, response.body['msg']);
      }
    } catch (e) {
      e.printError();
      responseModel = ResponseModel(false, 'someErrorHappened');
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> updatePassword(String email, String password) async {
    _isLoading = true;
    update();
    // if (_updatePassBody == null) {
    //   ResponseModel(false, 'Error saving data');
    // }
    late ResponseModel responseModel;

    try {
      // debugPrint('Auh Con:  ${_updatePassBody.toString()}');
      Response response = await authRepo.updatePassword(email, password);
      if (response.statusCode == 200) {
        responseModel = ResponseModel(true, 'Password updated successfully');
      } else {
        printResponseInfo(response, "Update Password");
        responseModel = ResponseModel(false, 'error');

        if ((response.body['errors']) != null) {
          responseModel = ResponseModel(
              false, '${(response.body['errors'])[0]['message']}');
        } else {
          responseModel = ResponseModel(false, 'error');
        }
      }
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      e.printError();
      _isLoading = false;
      update();
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearSavedData() {
    return authRepo.clearSavedData();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  String getUserEmail() {
    return authRepo.getUserEmail();
  }

  String getUserName() {
    return authRepo.getUserName();
  }

  String getCurrentLanguage() {
    if (storage.read('language') != null) {
      return storage.read('language');
    } else {
      return 'english';
    }
  }

  getLanguageState() {
    if (storage.read('language') != null) {
      return setLanguage(storage.read('language'));
    }
    setLanguage('english');
  }

  void setLanguage(String value) {
    storage.write('language', value);

    Get.updateLocale(value == 'system'
        ? Get.deviceLocale!
        : Locale(value == 'english' ? 'en' : 'ar'));

    update();
  }
}
