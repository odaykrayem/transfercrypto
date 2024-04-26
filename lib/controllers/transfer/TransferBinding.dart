// ignore_for_file: file_names
import 'package:get/get.dart';
import '../../data/repository/transfer_repo.dart';
import 'TransferController.dart';

class TransferBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferRepo>(() => TransferRepo(apiClient: Get.find()));
    Get.lazyPut<TransferController>(() => TransferController(repo: Get.find()));
    // Get.put<TransferController>(TransferController(repo: Get.find()),
    //     permanent: true);
  }
}
