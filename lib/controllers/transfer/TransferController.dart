// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';
import 'package:transfercrypto/services/networking/print_response_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/repository/transfer_repo.dart';
import '../../models/method_model.dart';
import '../../models/transfer_methods_values_model.dart';
import '../../models/response_model.dart';
import '../home/HomeController.dart';

class TransferController extends GetxController {
  final TransferRepo repo;

  TransferController({
    required this.repo,
  });

/**
 * _transferMethodValuesList this list has all info
 * _transferMethodsList this list has unique data about tranfer methods
 * _receiveMethodsList this list has receieve methods list according to selected transfer method
 */
  List<TransferMethodValueModel> _transferMethodValuesList = [];
  List<TransferMethodValueModel> get transferMethodValuesList =>
      _transferMethodValuesList;

  List<MethodModel> _transferMethodsList = [];
  List<MethodModel> get transferMethodsList => _transferMethodsList;

  List<MethodModel> _receiveMethodsList = [];
  List<MethodModel> get receiveMethodsList => _receiveMethodsList;

  MethodModel? _selectedTransferMethod;
  MethodModel? get selectedTransferMethod => _selectedTransferMethod;
  void setSelectedTransferMethod(MethodModel i) {
    _selectedTransferMethod = i;
    update();
  }

  MethodModel? _selectedReceiveMethod;
  MethodModel? get selectedReceiveMethod => _selectedReceiveMethod;
  void setSelectedReceiveMethod(MethodModel i) {
    _selectedReceiveMethod = i;
    update();
  }

  //Selected Method is method with all data transfer receive and commision and others
  TransferMethodValueModel? _selectedMethod;
  TransferMethodValueModel? get selectedMethod => _selectedMethod;
  void setSelectedMethod(TransferMethodValueModel i) {
    _selectedMethod = i;
    update();
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  bool _methodValuesLoaded = false;
  bool get methodValuesLoaded => _methodValuesLoaded;
  bool _addLoading = false;
  bool get addLoading => _addLoading;
  bool _errorLoading = false;
  bool get errorLoading => _errorLoading;

  //First step
  double? _inputAmount;
  double? get inputAmount => _inputAmount;

  double? _inputAmountAfterFee;
  double? get inputAmountAfterFee => _inputAmountAfterFee;

  double? _exchangeValue;
  double? get exchangeValue => _exchangeValue;

  void setAmount(double amount, double amountAfterFee, double exchangeValue) {
    _inputAmount = amount;
    _inputAmountAfterFee = amountAfterFee;
    _exchangeValue = exchangeValue;
  }

  //Second Step
  String? _inputUserFullName;
  String? get inputUserFullName => _inputUserFullName;

  String? _inputUserEmail;
  String? get inputUserEmail => _inputUserEmail;
  void setInputUserEmail({required String? userEmail}) {
    _inputUserEmail = userEmail;
  }

  String? _inputUserPhone;
  String? get inputUserPhone => _inputUserPhone;

  String? _inputUserCity;
  String? get inputUserCity => _inputUserCity;

  String? _inputUserWalletId;
  String? get inputUserWalletId => _inputUserWalletId;

  void setSecondStepDetails(
      {required String? userEmail,
      required String? userFullName,
      required String? userPhone,
      required String? userCity,
      required String? userWalletId}) {
    _inputUserEmail = userEmail;
    _inputUserPhone = userPhone;
    _inputUserCity = userCity;
    _inputUserFullName = userFullName;
    _inputUserWalletId = userWalletId;
  }

  //Third Step

  String? _inputUserOperationCode;
  String? get inputUserOperationCode => _inputUserOperationCode;

  XFile? _userReceiptImage;
  XFile? get userReceiptImage => _userReceiptImage;

  String? _userReceiptImagePath;
  String? get userReceiptImagePath => _userReceiptImagePath;

  bool _receiptImageSelected = false;
  bool get receiptImageSelected => _receiptImageSelected;

  void setReceiptImageSelected(
      bool i, XFile userReceiptImage, String userReceiptImagePath) {
    // debugPrint('image picked2 ${userReceiptImagePath}');

    _receiptImageSelected = i;
    _userReceiptImage = userReceiptImage;
    _userReceiptImagePath = userReceiptImagePath;
    update();
  }

  void setThirdStepDetails({
    required String? userOperationCode,
    required XFile? userReceiptImage,
  }) {
    _inputUserOperationCode = userOperationCode;
    _userReceiptImage = userReceiptImage;
  }

  void resetAllDetails(bool withAmount) {
    _inputUserEmail = null;
    _inputUserPhone = null;
    _inputUserCity = null;
    _inputUserFullName = null;
    _inputUserWalletId = null;
    _inputUserOperationCode = null;
    _userReceiptImage = null;
    if (withAmount) {
      _inputAmount = null;
      _inputAmountAfterFee = null;
      _exchangeValue = null;
    }
  }

  static TransferController get to => Get.find();

  HomeController homeControler = Get.find<HomeController>();

  Map<String, String> _adminValueMap = {};
  Map<String, String> get adminValueMap => _adminValueMap;
  late PageController _pageViewController;
  PageController get pageViewController => _pageViewController;
  HomeController homeController = Get.find<HomeController>();

  @override
  void onInit() {
    _pageViewController = PageController(
      initialPage: 0,
    );
    getMethodsValuesList();
    getAdminValueMap();
    super.onInit();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  void toFirstPage() {
    _pageViewController.jumpToPage(0);
    // _pageViewController.animateToPage(0,
    //     duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void nextPage() {
    _pageViewController.animateToPage(_pageViewController.page!.toInt() + 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void previousPage() {
    _pageViewController.animateToPage(_pageViewController.page!.toInt() - 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void getAdminValueMap() {
    if (!_adminValueMap.isEmpty) {
      return;
    }
    homeControler.adminValuesList.forEach((element) {
      _adminValueMap[element.key] = element.value;
    });
    // _adminValueMap.forEach((key, value) {
    //   debugPrint('MApp ${key} ${value}');
    // });
  }

  void updateValues() {
    debugPrint('transfer ${_selectedTransferMethod!.wallet_name}');
    debugPrint('receive ${_selectedReceiveMethod!.wallet_name}');
    _methodValuesLoaded = false;
    _selectedMethod = _transferMethodValuesList.firstWhereOrNull((element) =>
        element.transfer_wallet_name == selectedTransferMethod!.wallet_name &&
        element.receive_wallet_name == selectedReceiveMethod!.wallet_name);
    _methodValuesLoaded = true;

    update();
    // }
  }

  void updateReceiveList() {
    _receiveMethodsList = [];
    _transferMethodValuesList.forEach(
      (element) {
        if (element.transfer_wallet_name ==
            _selectedTransferMethod!.wallet_name) {
          _receiveMethodsList.add(new MethodModel(
              wallet_name: element.receive_wallet_name,
              wallet_icon: element.receive_wallet_icon));
        }
      },
    );
    debugPrint('Receive List');

    _receiveMethodsList.forEach((element) {
      debugPrint('${element.toString()}');
    });
    _selectedReceiveMethod = _receiveMethodsList[0];
    update();
  }

  Future<void> getMethodsValuesList() async {
    _errorLoading = false;
    _isLoaded = false;
    var idSet = <String>{};
    try {
      Response response = await repo.getTransferMethodsValuesList();
      printResponseInfo(response, "Methods Values List");
      if (response.statusCode == 200) {
        _transferMethodValuesList = [];
        _transferMethodsList = [];
        _receiveMethodsList = [];
        List<dynamic> map = response.body['data'];
        _transferMethodValuesList = map
            .map((elemnt) => TransferMethodValueModel.fromMap(elemnt))
            .toList();

        List<TransferMethodValueModel> uniqueList = [];
        for (var o in _transferMethodValuesList) {
          if (idSet.add(o.transfer_wallet_name)) {
            uniqueList.add(o);
          }
        }
        uniqueList.forEach((element) {
          _transferMethodsList.add(new MethodModel(
              wallet_name: element.transfer_wallet_name,
              wallet_icon: element.transfer_wallet_icon));
        });
        _selectedTransferMethod = _transferMethodsList[0];

        _transferMethodValuesList.forEach(
          (element) {
            if (element.transfer_wallet_name ==
                _selectedTransferMethod!.wallet_name) {
              _receiveMethodsList.add(new MethodModel(
                  wallet_name: element.receive_wallet_name,
                  wallet_icon: element.receive_wallet_icon));
            }
          },
        );
        _selectedReceiveMethod = _receiveMethodsList[0];

        updateValues();
        // _transferMethodValuesList.forEach((element) {
        //   debugPrint(element.toString());
        // });
        _isLoaded = true;
        update(); //it works like setState to update ui
      } else if (response.statusCode == 500) {
        if ('${response.body}'.contains('Route [login] not defined')) {
          homeController.logout();
        }
      } else {
        debugPrint(' controller : could not get methods values');
        _errorLoading = true;
        _isLoaded = true;
        update();
      }
    } catch (e) {
      debugPrint('catch Error ${e.toString()}');
      e.printInfo();
      e.printError();
      _errorLoading = true;

      _isLoaded = true;
      update();
    }
  }

  Future<ResponseModel> addTransaction(bool isCTW, Uint8List? imageData) async {
    _addLoading = true;
    update();
    Map<String, dynamic> data = {
      "send_amount": _inputAmount,
      "receive_amount": _inputAmountAfterFee,
      "commission": _selectedMethod!.commission,
      "from_wallet": _selectedMethod!.transfer_wallet_name,
      "from_wallet_icon": _selectedMethod!.transfer_wallet_icon,
      "to_wallet": _selectedMethod!.receive_wallet_name,
      "to_wallet_icon": _selectedMethod!.receive_wallet_icon,
      "admin_wallet": _selectedMethod!.admin_wallet_name,
      "user_wallet_id": _inputUserWalletId,
      "user_op_code": _inputUserOperationCode,
      "user_full_name": _inputUserFullName,
      "user_phone": _inputUserPhone,
      "user_place": _inputUserCity,
      "user_email": _inputUserEmail,
    };
    late ResponseModel responseModel;
    try {
      Response response =
          await repo.addTransaction(data: data, imageData: imageData);
      // printResponseInfo(response, 'Add transaction');
      if (response.statusCode == 200 || response.statusCode == 201) {
        responseModel = ResponseModel(true, 'sucess'.tr);
      } else if (response.statusCode == 500) {
        if ('${response.body}'.contains('Route [login] not defined')) {
          homeController.logout();
        }
      } else {
        responseModel = ResponseModel(false, response.statusText!);
        debugPrint('failed add transaction');
      }
      _addLoading = false;
      update();

      return responseModel;
    } catch (e) {
      _addLoading = false;
      update();
      responseModel = ResponseModel(false, 'error');
      debugPrint('error add transaction ${e.toString()}');
      e.printError();

      return responseModel;
    }
  }
}

//  Future<ResponseModel> addCTW(
//       Map<String, dynamic> data, File image, Uint8List imageData) async {
//     _addLoading = true;
//     update();
//     late ResponseModel responseModel;
//     // debugPrint('ctw cont ${image.path}');
//     try {
//       Response response = await repo.addCTW(data, image, imageData);
//       printResponseInfo(response, 'Add CTW');
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         debugPrint('Con: Add Ctw');
//         responseModel = ResponseModel(true, 'sucess'.tr);
//       } else {
//         responseModel = ResponseModel(false, response.statusText!);
//         debugPrint('failed');
//       }
//       _addLoading = false;
//       update();

//       return responseModel;
//     } catch (e) {
//       _addLoading = false;
//       update();
//       responseModel = ResponseModel(false, 'error');
//       debugPrint('catch error');
//       debugPrint('${e.toString()}');
//       e.printError();

//       return responseModel;
//     }
//   }

// Future<ResponseModel> addWTW(Map<String, dynamic> data) async {
//     _addLoading = true;
//     update();

//     late ResponseModel responseModel;

//     try {
//       Response response = await repo.addWTW(data);
//       printResponseInfo(response, 'Add WTW');
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         debugPrint('Con: Add Wtw');
//         responseModel = ResponseModel(true, 'sucess'.tr);
//       } else {
//         responseModel = ResponseModel(false, response.statusText!);
//         debugPrint('failed');
//       }
//       _addLoading = false;
//       update();

//       return responseModel;
//     } catch (e) {
//       _addLoading = false;
//       update();
//       responseModel = ResponseModel(false, 'error');

//       return responseModel;
//     }
//   }

//  Future<ResponseModel> addWTC(Map<String, dynamic> data) async {
//     _addLoading = true;
//     update();

//     late ResponseModel responseModel;

//     try {
//       Response response = await repo.addWTC(data);
//       printResponseInfo(response, 'Add WTC');
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         debugPrint('Con: Add Wtc');
//         responseModel = ResponseModel(true, 'sucess'.tr);
//       } else {
//         responseModel = ResponseModel(false, response.statusText!);
//         debugPrint('failed');
//       }
//       _addLoading = false;
//       update();

//       return responseModel;
//     } catch (e) {
//       _addLoading = false;
//       update();
//       responseModel = ResponseModel(false, 'error');

//       return responseModel;
//     }
//   }