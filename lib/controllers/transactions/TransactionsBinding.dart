// ignore_for_file: file_names
import 'package:transfercrypto/data/repository/transactions_repo.dart';
import 'package:get/get.dart';
import 'TransactionsController.dart';

class TransactionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionsRepo>(
        () => TransactionsRepo(apiClient: Get.find()));
    Get.lazyPut<TransactionsController>(
        () => TransactionsController(repo: Get.find()));
  }
}
