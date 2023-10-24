import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'getDeviceType.dart';

void openDialogUtil(
    {required Widget child, double? width, double? height, double? padding}) {
  if (Get.isDialogOpen == true) Get.back();
  // double dialogWidth =
  //     getDeviceType() == 'phone' ? Get.size.width + 50 : Get.size.width / 3;
  // double hPadding = getDeviceType() == 'phone' ? 5 : 30;
  Get.defaultDialog(
      title: '',
      titlePadding: const EdgeInsets.all(0),
      radius: 15,
      contentPadding: EdgeInsets.all(padding ?? 0),
      barrierDismissible: false,
      content: Stack(
        children: [
          SizedBox(
              width: width ?? Get.size.width / 2,
              height: height ?? Get.size.height - 130,
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
        ],
      ));
}
