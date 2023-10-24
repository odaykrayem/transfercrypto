// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:get/get.dart';
// import '../../constants/api_constants.dart';
// import '../../services/networking/api_client.dart';

// class WalletToCashRepo extends GetxService {
//   final ApiClient apiClient;

//   WalletToCashRepo({
//     required this.apiClient,
//   });

//   Future<Response> getList() async {
//     return await apiClient.getData(ApiConstants.walletToCashList);
//   }

//   Future<Response> add(Map<String, dynamic> data) async {
//     return await apiClient.postData(ApiConstants.addWalletToCash, data);
//   }
// }
