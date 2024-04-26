// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:transfercrypto/constants/api_constants.dart';
import 'package:get/get.dart';
import '../../services/networking/api_client.dart';

class UserRepo {
  final ApiClient apiClient;

  UserRepo({
    required this.apiClient,
  });

  Future<Response> getUserInfo() async {
    return await apiClient.getData(
      ApiConstants.USER_INFO_URI,
    );
  }

  // Future<Response> withdrawBalance(
  //     double balanceToWithdraw, String bankCode) async {
  //   return await apiClient.postData(AppConstants.WITHDRAW_BALANCE, {
  //     'amount': balanceToWithdraw,
  //     'bank_code': bankCode,
  //   });
  // }
}
