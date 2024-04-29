// ignore_for_file: file_names
import 'package:transfercrypto/views/about_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/app_constants.dart';
import '../../data/repository/home_repo.dart';
import '../../models/admin_value.dart';
import '../../routes/sub_routes.dart';
import '../../services/networking/print_response_info.dart';
import '../../utils/getDeviceType.dart';
import '../../views/home_view.dart';
import '../../views/transactions.dart';
import '../../views/transfer.dart';
import '../auth/auth_controller.dart';
import '../transactions/TransactionsBinding.dart';
import '../transfer/TransferBinding.dart';

class HomeController extends GetxController {
  final HomeRepo repo;
  HomeController({required this.repo});
  // late PageController pageController;
  final GlobalKey<ScaffoldState> key = GlobalKey(); // Create a key

  List<AdminValue> _adminValuesList = [];
  List<AdminValue> get adminValuesList => _adminValuesList;
  bool _isAdminValuesLoaded = false;
  bool get isAdminValuesLoaded => _isAdminValuesLoaded;
  bool _isErrorLoadingAdminValues = false;
  bool get isErrorLoadingAdminValues => _isErrorLoadingAdminValues;
  @override
  void onInit() {
    isLoggedIn();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAdminInfo();
    });
    super.onInit();
  }

  Future<void> getAdminInfo() async {
    // _errorLoading = false;
    _isAdminValuesLoaded = false;
    _isErrorLoadingAdminValues = false;

    try {
      Response response = await repo.getAdminInfo();
      printResponseInfo(response, "Admin Values List");
      if (response.statusCode == 200) {
        _adminValuesList = []; //initialze to not repeat data
        List<dynamic> map = response.body['data'];
        _adminValuesList =
            map.map((elemnt) => AdminValue.fromMap(elemnt)).toList();
        // _adminValuesList.forEach((element) {
        //   debugPrint(element.toString());
        // });
        _isAdminValuesLoaded = true;
        update(); //it works like setState to update ui
      } else {
        debugPrint('home controller : could not get admin values');
        // _errorLoading = true;
        _isAdminValuesLoaded = true;
        _isErrorLoadingAdminValues = true;
        update();
      }
    } catch (e) {
      debugPrint('catch Error home controller ${e.toString()}');
      e.printInfo();
      e.printError();
      // _errorLoading = true;

      _isAdminValuesLoaded = true;
      _isErrorLoadingAdminValues = true;

      update();
    }
  }

  static HomeController get to => Get.find();
  AuthController authController = Get.find<AuthController>();

  final storage = GetStorage();

  var currentIndex = 0.obs;
  var _userLoggedIn = false;
  bool get userLoggedIn => _userLoggedIn;

  final pages = <String>[
    SubRoutes.home,
    SubRoutes.transactions,
    SubRoutes.about,
    SubRoutes.guide,
  ];

  void changePage(int index) {
    currentIndex.value = index;
    Get.toNamed(pages[index], id: 1);
  }

  void setUserIsLoggedIn(bool state) {
    _userLoggedIn = state;
    update();
  }

  bool isLoggedIn() {
    _userLoggedIn = storage.read(AppConstants.token) != null;

    return storage.read(AppConstants.token) != null;
  }

  Route onGenerateRoute(RouteSettings settings) {
    if (settings.name == pages[0]) {
      return GetPageRoute(
        settings: settings,
        page: () => HomeView(),
        transitionDuration: Duration(milliseconds: 0),
        transition: Transition.noTransition,
      );
    }

    if (settings.name == pages[1]) {
      return GetPageRoute(
        settings: settings,
        page: () => Transactions(),
        transitionDuration: Duration(milliseconds: 0),
        transition: Transition.noTransition,
        binding: TransactionsBinding(),
        maintainState: false,
      );
    }
    if (settings.name == pages[2]) {
      return GetPageRoute(
        settings: settings,
        page: () => const AboutView(),
        transitionDuration: Duration(milliseconds: 0),
        transition: Transition.noTransition,
      );
    }
    if (settings.name == pages[3]) {
      return GetPageRoute(
        settings: settings,
        page: () => Transfer(),
        transitionDuration: Duration(milliseconds: 0),
        transition: Transition.noTransition,
        maintainState: false,
        binding: TransferBinding(),
      );
    }
    // return GetPageRoute(
    //   settings: settings,
    //   page: () => Transactions(),
    //   transitionDuration: Duration(milliseconds: 0),
    //   transition: Transition.noTransition,
    //   binding: TransactionsBinding(),
    // );
    return GetPageRoute(
      settings: settings,
      page: () => HomeView(),
      transitionDuration: Duration(milliseconds: 0),
      transition: Transition.noTransition,
    );
  }

  void logout() {
    authController.clearSavedData();
    Get.back();
    changePage(0);
  }

  void openDrawer() {
    key.currentState!.openDrawer();
  }

  void closeDrawer() {
    if (key.currentState!.isDrawerOpen) {
      key.currentState!.closeDrawer();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void openDialog(Widget child) {
    if (Get.isDialogOpen == true) Get.back();
    double dialogWidth =
        getDeviceType() == 'phone' ? Get.size.width + 50 : Get.size.width / 3;
    double hPadding = getDeviceType() == 'phone' ? 5 : 30;
    authController.setIsLoading(false);

    Get.defaultDialog(
        title: '',
        titlePadding: const EdgeInsets.all(0),
        radius: 15,
        contentPadding: EdgeInsets.symmetric(horizontal: hPadding),
        barrierDismissible: false,
        content: SingleChildScrollView(
          child: SizedBox(
              width: dialogWidth,
              height: Get.size.height - 130,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: child,
                  ),
                  Get.locale != const Locale('ar')
                      ? Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.clear_rounded,
                            ),
                          ),
                        )
                      : Positioned(
                          top: 0,
                          left: 0,
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.clear_rounded,
                            ),
                          ),
                        )
                ],
              )),
        ));
  }
}
