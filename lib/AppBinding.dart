// ignore_for_file: file_names
import 'package:transfercrypto/controllers/auth/auth_controller.dart';
import 'package:transfercrypto/controllers/home/HomeController.dart';
import 'package:transfercrypto/controllers/user/user_controller.dart';
import 'package:transfercrypto/data/repository/auth_repo.dart';
import 'package:transfercrypto/data/repository/home_repo.dart';
import 'package:transfercrypto/data/repository/user_repo.dart';
import 'package:transfercrypto/services/networking/api_client.dart';
import 'package:get/instance_manager.dart';
import 'constants/api_constants.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(BaseProvider(), permanent: true);
    // Get.put(ApiService(Get.find()), permanent: true);
    // Get.put(GetXNetworkManager(), permanent: true);
    Get.put(ApiClient(appBaseUrl: ApiConstants.baseUrl), permanent: true);

    Get.lazyPut<AuthRepo>(() => AuthRepo(apiClient: Get.find()));
    Get.lazyPut<AuthController>(() => AuthController(authRepo: Get.find()));
    Get.put(HomeController, permanent: true);
    Get.lazyPut<HomeRepo>(() => HomeRepo(apiClient: Get.find()));
    // Get.lazyPut<HomeController>(() => HomeController(repo: Get.find()));
    Get.lazyPut<UserRepo>(() => UserRepo(apiClient: Get.find()));
    Get.lazyPut<UserController>(() => UserController(repo: Get.find()));

    // Get.lazyPut<TransferRepo>(() => TransferRepo(apiClient: Get.find()));
    // Get.lazyPut<TransferController>(() => TransferController(repo: Get.find()));
    // Get.put<TransferController>(TransferController(repo: Get.find()),
    //     permanent: true);
  }
}
