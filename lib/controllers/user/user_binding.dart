// ignore_for_file: file_names
import 'package:transfercrypto/controllers/user/user_controller.dart';
import 'package:get/get.dart';

import '../../data/repository/user_repo.dart';

class UserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepo>(() => UserRepo(apiClient: Get.find()));
    Get.lazyPut<UserController>(() => UserController(repo: Get.find()));
  }
}
