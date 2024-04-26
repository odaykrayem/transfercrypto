// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:transfercrypto/services/networking/print_response_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repository/transactions_repo.dart';
import '../../models/transaction_model.dart';
import '../home/HomeController.dart';

class TransactionsController extends GetxController {
  final TransactionsRepo repo;

  TransactionsController({
    required this.repo,
  });

  TransactionModel? _selectedTransactionModel;
  TransactionModel? get selectedTransactionModel => _selectedTransactionModel;
  late PageController _pageViewController;
  PageController get pageViewController => _pageViewController;

  @override
  void onInit() {
    _pageViewController = PageController(
      initialPage: 0,
    );
    super.onInit();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  void nextPage(TransactionModel transactionModel) {
    _selectedTransactionModel = transactionModel;
    _pageViewController.animateToPage(_pageViewController.page!.toInt() + 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void previousPage() {
    _selectedTransactionModel = null;
    _pageViewController.animateToPage(_pageViewController.page!.toInt() - 1,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  List<TransactionModel> _transactionsList = [];
  List<TransactionModel> get transactionsList => _transactionsList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  bool _addLoading = false;
  bool get addLoading => _addLoading;
  bool _errorLoading = false;
  bool get errorLoading => _errorLoading;
  HomeController homeController = Get.find<HomeController>();

  Future<void> getTransactionsList() async {
    _errorLoading = false;
    _isLoaded = false;

    try {
      Response response = await repo.getTransactionsList();
      // printResponseInfo(response, "Transactions List");
      if (response.statusCode == 200) {
        _transactionsList = []; //initialze to not repeat data
        List<dynamic> map = response.body['data'];
        _transactionsList =
            map.map((elemnt) => TransactionModel.fromMap(elemnt)).toList();
        // _wtcList.forEach((element) {
        //   debugPrint(element.toString());
        // });
        _isLoaded = true;
        update();
      } else if (response.statusCode == 500) {
        if ('${response.body}'.contains('Route [login] not defined')) {
          homeController.logout();
        }
      } else {
        debugPrint('transactions controller : could not get ');
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

  // List<WalletToCashModel> _wtcList = [];
  // List<WalletToCashModel> get wtcList => _wtcList;

  // List<CashToWalletModel> _ctwList = [];
  // List<CashToWalletModel> get ctwList => _ctwList;

  // List<WalletToWalletModel> _wtwList = [];
  // List<WalletToWalletModel> get wtwList => _wtwList;

  // Future<void> getWTCList() async {
  //   _errorLoading = false;
  //   _isLoaded = false;

  //   try {
  //     Response response = await repo.getWTCList();
  //     printResponseInfo(response, "Wallet To Cash List");
  //     if (response.statusCode == 200) {
  //       _wtcList = []; //initialze to not repeat data
  //       List<dynamic> map = response.body['data'];
  //       _wtcList =
  //           map.map((elemnt) => WalletToCashModel.fromMap(elemnt)).toList();
  //       // _wtcList.forEach((element) {
  //       //   debugPrint(element.toString());
  //       // });
  //       _isLoaded = true;
  //       update(); //it works like setState to update ui
  //     } else {
  //       debugPrint('transactions controller : could not get ');
  //       _errorLoading = true;
  //       _isLoaded = true;
  //       update();
  //     }
  //   } catch (e) {
  //     debugPrint('catch Error ${e.toString()}');
  //     e.printInfo();
  //     e.printError();
  //     _errorLoading = true;

  //     _isLoaded = true;
  //     update();
  //   }
  // }

  // Future<void> getCTWList() async {
  //   _errorLoading = false;
  //   _isLoaded = false;

  //   try {
  //     Response response = await repo.getCTWList();
  //     printResponseInfo(response, "Cash To Wallet List");
  //     if (response.statusCode == 200) {
  //       _ctwList = []; //initialze to not repeat data
  //       List<dynamic> map = response.body['data'];
  //       _ctwList =
  //           map.map((elemnt) => CashToWalletModel.fromMap(elemnt)).toList();
  //       _ctwList.forEach((element) {
  //         debugPrint(element.toString());
  //       });
  //       _isLoaded = true;
  //       update(); //it works like setState to update ui
  //     } else {
  //       debugPrint(' controller : could not get ');
  //       _errorLoading = true;
  //       _isLoaded = true;
  //       update();
  //     }
  //   } catch (e) {
  //     debugPrint('catch Error ${e.toString()}');
  //     e.printInfo();
  //     e.printError();
  //     _errorLoading = true;

  //     _isLoaded = true;
  //     update();
  //   }
  // }

  // Future<void> getWTWList() async {
  //   _errorLoading = false;
  //   _isLoaded = false;

  //   try {
  //     Response response = await repo.getWTWList();
  //     printResponseInfo(response, "Wallet To Wallet List");
  //     if (response.statusCode == 200) {
  //       _wtwList = []; //initialze to not repeat data
  //       List<dynamic> map = response.body['data'];
  //       _wtwList =
  //           map.map((elemnt) => WalletToWalletModel.fromMap(elemnt)).toList();
  //       _wtwList.forEach((element) {
  //         debugPrint(element.toString());
  //       });
  //       _isLoaded = true;
  //       update(); //it works like setState to update ui
  //     } else {
  //       debugPrint('transactions controller : could not get ');
  //       _errorLoading = true;
  //       _isLoaded = true;
  //       update();
  //     }
  //   } catch (e) {
  //     debugPrint('transactions controller catch Error ${e.toString()}');
  //     e.printInfo();
  //     e.printError();
  //     _errorLoading = true;

  //     _isLoaded = true;
  //     update();
  //   }
  // }
}
