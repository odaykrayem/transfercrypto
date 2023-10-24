import 'package:get/route_manager.dart';
import 'package:transfercrypto/controllers/home/HomeBinding.dart';
import 'package:transfercrypto/views/layout_template.dart';
import '../screens/no_connection.dart';
import '../screens/splash_screen.dart';
// import 'dart:convert';
// import '../controllers/transfer/TransferBinding.dart';
// import '../models/transaction_model.dart';
// import '../views/transaction_details.dart';

class Routes {
  static const String main = "/main";
  static const String splash = "/splash";
  static const String home = "/home";
  static const String noConnection = "/no_connection";
  static const String transactionDetails = "/details";

  static String getMain() => main;
  static String getSplash() => splash;
  static String getHome() => home;
  static String getNoConnection() => noConnection;
  // static String getTransactionDetails(String details) =>
  //     '$transactionDetails?details=${base64.encode(utf8.encode('$details'))}';

  static final routes = [
    GetPage(name: main, page: () => LayoutTemplate(), binding: HomeBinding()),
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: noConnection,
      page: () => const NoConnection(),
    ),
    // GetPage(
    //   name: transactionDetails,
    //   page: () {
    //     var model = TransactionModel.fromJson(
    //         utf8.decode(base64.decode(Get.parameters['details']!)));

    //     return TransactionDetails(
    //       transactionModel: model,
    //     );
    //   },
    //   binding: TransferBinding(),
    // ),
  ];
}
