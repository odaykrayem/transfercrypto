import 'dart:math';

import 'package:get/route_manager.dart';
import 'package:transfercrypto/controllers/home/HomeBinding.dart';
import 'package:transfercrypto/controllers/reviews/ReviewsBinding.dart';
import 'package:transfercrypto/extensions/bool_parsing.dart';
import 'package:transfercrypto/views/enterEmail.dart';
import 'package:transfercrypto/views/layout_template.dart';
import 'package:transfercrypto/views/login.dart';
import 'package:transfercrypto/views/otp.dart';
import 'package:transfercrypto/views/profile_view.dart';
import 'package:transfercrypto/views/register.dart';
import 'package:transfercrypto/views/reviews.dart';
import 'package:transfercrypto/views/update_pass.dart';
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
  static const String login = "/log-in";
  static const String signup = "/sign-up";
  static const String enterEmail = "/e-email";
  static const String otp = "/f-otp";
  static const String updatePass = "/p-udate";
  static const String profile = "/c-profile";
  static const String reviews = "/r-reviews";

  static String getMain() => main;
  static String getSplash() => splash;
  static String getHome() => home;
  static String getNoConnection() => noConnection;
  static String getLogin() => login;
  static String getSignup() => signup;
  static String getEnterEmail() => enterEmail;
  static String getOtp(String email, bool isRegisterProcess) =>
      '$otp?email=$email&irp=$isRegisterProcess';
  static String getUpdatePass(String email) => '$updatePass?email=$email';
  static String getProfile() => profile;
  static String getReviews() => reviews;

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
    GetPage(
      name: login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: signup,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: enterEmail,
      page: () => const EnterEmailPage(),
    ),
    GetPage(
      name: otp,
      page: () {
        var email = Get.parameters['email'];
        var irp = Get.parameters['irp'];
        return OtpPage(email: email!, isRegisterProcess: irp!.parseBool());
      },
    ),
    GetPage(
      name: updatePass,
      page: () {
        var email = Get.parameters['email'];
        return UpdatePass(email: email!);
      },
    ),
    GetPage(
      name: profile,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: reviews,
      page: () => ReviewsPage(),
      binding: ReviewsBinding(),
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
