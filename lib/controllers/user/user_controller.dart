import 'package:transfercrypto/controllers/home/HomeController.dart';
import 'package:get/get.dart';
import '../../data/repository/user_repo.dart';
import '../../models/response_model.dart';
import '../../models/user_model.dart';
import '../../services/networking/print_response_info.dart';

class UserController extends GetxController {
  final UserRepo repo;

  UserController({required this.repo});

  bool _loaded = false;
  bool get loaded => _loaded;

  bool _isErrorLoadingInfo = false;
  bool get isErrorLoadingInfo => _isErrorLoadingInfo;
  UserModel? _userModel;

  UserModel? get userModel => _userModel;
  HomeController homeController = Get.find<HomeController>();

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  Future<ResponseModel> getUserInfo() async {
    _isErrorLoadingInfo = false;
    _loaded = false;
    late ResponseModel responseModel;

    try {
      Response response = await repo.getUserInfo();
      // printResponseInfo(response, "USer Info");

      if (response.statusCode == 200) {
        _userModel = UserModel.fromJson(response.body['data']);
        responseModel = ResponseModel(true, 'Successfully');
        _isErrorLoadingInfo = false;
        _loaded = true;
        update();
      } else if (response.statusCode == 500) {
        if ('${response.body}'.contains('Route [login] not defined')) {
          responseModel = ResponseModel(false, response.statusText!);
          _isErrorLoadingInfo = true;
          _loaded = true;

          update();
          homeController.logout();
        }
      } else {
        responseModel = ResponseModel(false, response.statusText!);
        _isErrorLoadingInfo = true;
        _loaded = true;
        update();
        // printResponseInfo(response, "USer Info");
      }
    } catch (e) {
      e.printError();
      responseModel = ResponseModel(false, 'connection error');
      _isErrorLoadingInfo = true;
      _loaded = true;
      update();
    }
    return responseModel;
  }
}
