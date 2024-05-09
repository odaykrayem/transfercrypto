// ignore_for_file: file_names
import 'package:transfercrypto/data/repository/review_repo.dart';
import 'package:get/get.dart';
import 'ReviewsController.dart';

class ReviewsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewsRepo>(() => ReviewsRepo(apiClient: Get.find()));
    Get.lazyPut<ReviewsController>(() => ReviewsController(repo: Get.find()));
  }
}
