import 'package:transfercrypto/controllers/auth/auth_controller.dart';
import 'package:transfercrypto/extensions/hover_pointer_extinsion.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:transfercrypto/models/transaction_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transfercrypto/widgets/custom_gesture.dart';

import '../constants/api_constants.dart';
import '../constants/app_colors.dart';
import '../controllers/transactions/TransactionsController.dart';
import '../data/status_values.dart';
import '../utils/open_diaolg.dart';
import '../widgets/hover_widget.dart';
import "package:universal_html/html.dart" as html;
import 'dart:ui' as ui;

class TransactionDetails extends StatelessWidget {
  TransactionDetails({
    super.key,
  });

  final Color borderColor = Colors.grey[600]!;

  @override
  Widget build(BuildContext context) {
    debugPrint(
        '${Get.find<TransactionsController>().selectedTransactionModel.toString()}');
    final TransactionModel model =
        Get.find<TransactionsController>().selectedTransactionModel!;
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Container(
        padding:
            const EdgeInsets.only(top: 5.0, bottom: 20.0, left: 15, right: 15),
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.find<TransactionsController>().previousPage();
                    },
                    child: HoverWidget(builder: (context, isHoviring) {
                      return Container(
                        width: 60,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isHoviring
                                ? AppColors.secondaryColor
                                : AppColors.secondaryColor.withOpacity(0.5),
                            border: Border.all(color: Colors.transparent)),
                        child: Text(
                          'back'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isHoviring
                                  ? Colors.white
                                  : AppColors.primaryColor),
                        ),
                      );
                    }),
                  )
                ],
              ),
              10.height,
              Container(
                alignment: Alignment.center,
                width: sizingInformation.deviceScreenType ==
                        DeviceScreenType.mobile
                    ? 300
                    : 500,
                decoration:
                    BoxDecoration(border: Border.all(color: borderColor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    rowWidget(
                        title: 'from'.tr,
                        content: model.from_wallet.tr,
                        image2: (ApiConstants.imageUrl + model.from_wallet_icon)
                            .replaceAll('\\', '/')),
                    rowWidget(
                        title: 'to'.tr,
                        content: model.to_wallet.tr,
                        image2: (ApiConstants.imageUrl + model.to_wallet_icon)
                            .replaceAll('\\', '/')),
                    rowWidget(
                      title: 'send'.tr,
                      content: '${model.send_amount}',
                      icon1: Icons.arrow_upward_rounded,
                      icon1Color: Colors.blueAccent,
                      isLocale: true,
                    ),
                    rowWidget(
                      title: 'receive'.tr,
                      content: '${model.receive_amount}',
                      icon1: Icons.arrow_downward_rounded,
                      icon1Color: Colors.greenAccent,
                      isLocale: true,
                    ),
                    model.exchange_price != null
                        ? rowWidget(
                            title: 'exchangeValue'.tr,
                            content: '${model.exchange_price}',
                            icon1: Icons.money_rounded,
                            icon1Color: Colors.greenAccent,
                            isLocale: true,
                          )
                        : SizedBox.shrink(),
                    rowWidget(
                      title: 'payPrice'.tr,
                      content:
                          '1\$ = ${1 * model.commission / 100}', // to round 2 after point
                      isLocale: true,
                    ),
                    rowWidget(
                        title: 'account'.tr,
                        content: '',
                        child2: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.black87,
                                ),
                                3.width,
                                Text(
                                  model.user_full_name != null
                                      ? model.user_full_name!
                                      : '${Get.find<AuthController>().getUserName()}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            model.user_phone != null ? 3.height : 0.height,
                            model.user_phone != null
                                ? Text(
                                    model.user_phone!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                : SizedBox.shrink(),
                            model.user_email != null ? 3.height : 0.height,
                            model.user_email != null
                                ? Text(
                                    model.user_email!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black26,
                                    ),
                                  )
                                : SizedBox.shrink(),
                            model.user_wallet_id != null ? 3.height : 0.height,
                            model.user_wallet_id != null
                                ? Text(
                                    model.user_wallet_id!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ) // to round 2 after point
                        ),
                    rowWidget(
                      title: 'paymentDetails'.tr,
                      content: '',
                      child2: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${'operationDate'.tr} :  ${DateFormat('yyyy-MM-dd , hh:mm a').format(model.created_at)}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          3.height,
                          Text(
                            '${'operationId'.tr} :  #${model.id}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    model.status != 0
                        ? rowWidget(
                            title: 'payDate'.tr,
                            content:
                                '${DateFormat('yyyy-MM-dd , hh:mm a').format(model.updated_at)}')
                        : SizedBox.shrink(),
                    rowWidget(
                        title: 'status'.tr,
                        content: '',
                        child2: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${statusValues[model.status]}'),
                            10.width,
                            Icon(
                              model.status == 0
                                  ? Icons.access_time
                                  : model.status == 1
                                      ? Icons.done_all
                                      : Icons.do_not_disturb_alt_outlined,
                              color: model.status == 0
                                  ? Colors.blueAccent
                                  : model.status == 1
                                      ? Colors.greenAccent
                                      : Colors.red[400],
                              size: 25,
                            ),
                          ],
                        )),
                    model.message != null
                        ? rowWidget(
                            title: 'statusMessage'.tr,
                            content: '${model.message}')
                        : SizedBox.shrink(),
                    model.admin_op_code != null
                        ? rowWidget(
                            title: 'transferOPerationToYourAccountId'.tr,
                            content: '${model.admin_op_code}')
                        : SizedBox.shrink(),
                    model.admin_image != null
                        ? rowWidget(
                            title: 'transferOPerationToYourAccountImage'.tr,
                            content: '',
                            child2: CustomGesture(
                              onTap: () {
                                if (kIsWeb) {
                                  html.window.open(
                                      (ApiConstants.imageUrl +
                                              model.admin_image!)
                                          .replaceAll('\\', '/'),
                                      'img');
                                }
                                openDialogUtil(
                                  child: ImageNetwork(
                                    height:
                                        sizingInformation.deviceScreenType ==
                                                DeviceScreenType.mobile
                                            ? 400
                                            : 500,
                                    width: sizingInformation.deviceScreenType ==
                                            DeviceScreenType.mobile
                                        ? 400
                                        : 600,
                                    fitAndroidIos: BoxFit.contain,
                                    fitWeb: BoxFitWeb.contain,
                                    image: (ApiConstants.imageUrl +
                                            model.admin_image!)
                                        .replaceAll('\\', '/'),
                                  ),
                                  height: sizingInformation.deviceScreenType ==
                                          DeviceScreenType.mobile
                                      ? 400
                                      : 500,
                                  width: sizingInformation.deviceScreenType ==
                                          DeviceScreenType.mobile
                                      ? Get.size.width
                                      : 600,
                                );
                              },
                              child: ImageNetwork(
                                height: sizingInformation.deviceScreenType ==
                                        DeviceScreenType.mobile
                                    ? 200
                                    : 300,
                                width: sizingInformation.deviceScreenType ==
                                        DeviceScreenType.mobile
                                    ? 200
                                    : 300,
                                fitAndroidIos: BoxFit.contain,
                                fitWeb: BoxFitWeb.cover,
                                image:
                                    (ApiConstants.imageUrl + model.admin_image!)
                                        .replaceAll('\\', '/'),
                              ),
                            ))
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget rowWidget({
    required String title,
    required String content,
    IconData? icon1,
    Color? icon1Color,
    String? image2,
    Widget? child2,
    bool isLocale = false,
  }) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  icon1 != null
                      ? Icon(
                          icon1,
                          color: icon1Color,
                        )
                      : SizedBox.shrink(),
                  icon1 != null ? 3.width : 0.width,
                  Expanded(
                    child: Text(
                      title,
                      softWrap: true,
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: borderColor),
                      right: BorderSide(color: borderColor))),
              child: child2 ??
                  Row(
                    children: [
                      Flexible(
                        child: isLocale
                            ? Directionality(
                                textDirection: ui.TextDirection.ltr,
                                child: Text(
                                  content,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : Text(
                                content,
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                      image2 != null ? 5.width : 0.width,
                      image2 != null
                          ? ImageNetwork(
                              height: 60,
                              width: 60,
                              fitAndroidIos: BoxFit.contain,
                              fitWeb: BoxFitWeb.contain,
                              image: image2,
                            )
                          : SizedBox(
                              height: 40,
                            ),
                    ],
                  ),
            ),
          )
        ],
      ),
    );
  }
}
