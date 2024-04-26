import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/app_values.dart';

void showCustomSnackBar(String message,
    {bool isError = false, String title = AppValues.appName}) {
  //titleText and mesasgeText are customization
  Get.snackbar(
    title, message,
    titleText: Text(
      title,
      style: TextStyle(
        color: isError ? Colors.red : AppColors.primaryColor,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
    ),
    colorText: Colors.black,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.lightPurple,
    barBlur: 30,
    snackStyle: SnackStyle.GROUNDED,
    margin: EdgeInsets.all(5),

    // backgroundColor: isError ? Colors.redAccent : AppColors.mainColor,
  );
}
