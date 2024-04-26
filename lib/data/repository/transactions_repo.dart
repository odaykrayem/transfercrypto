// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import '../../constants/api_constants.dart';
import '../../services/networking/api_client.dart';

class TransactionsRepo extends GetxService {
  final ApiClient apiClient;

  TransactionsRepo({
    required this.apiClient,
  });

  Future<Response> getTransactionsList() async {
    return await apiClient.getData(ApiConstants.transactionsList);
  }

  // Future<Response> getWTCList() async {
  //   return await apiClient.getData(ApiConstants.walletToCashList);
  // }

  // Future<Response> getCTWList() async {
  //   return await apiClient.getData(ApiConstants.cashToWalletList);
  // }

  // Future<Response> getWTWList() async {
  //   return await apiClient.getData(ApiConstants.walletToWalletList);
  // }
}
