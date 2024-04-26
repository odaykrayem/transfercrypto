// ignore_for_file: file_names
import 'package:transfercrypto/controllers/auth/auth_controller.dart';
import 'package:get/get.dart';

import '../../constants/api_constants.dart';
import '../../data/repository/auth_repo.dart';
import '../../data/repository/home_repo.dart';
import '../../data/repository/user_repo.dart';
import '../../services/networking/api_client.dart';
import '../user/user_controller.dart';
import 'HomeController.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<CategoryRepository>(() => CategoryRepository(Get.find()));
    // Get.lazyPut<CategoryProvider>(() => CategoryProvider(Get.find()));

    Get.lazyPut<ApiClient>(() => ApiClient(appBaseUrl: ApiConstants.baseUrl));
    Get.lazyPut<HomeRepo>(() => HomeRepo(apiClient: Get.find()));
    Get.lazyPut<HomeController>(() => HomeController(repo: Get.find()));
    Get.lazyPut<AuthController>(() => AuthController(authRepo: Get.find()));
    Get.lazyPut(() => AuthRepo(apiClient: Get.find()));
    Get.lazyPut<UserRepo>(() => UserRepo(apiClient: Get.find()));
    Get.lazyPut<UserController>(() => UserController(repo: Get.find()));
  }
}
