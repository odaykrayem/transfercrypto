import 'package:transfercrypto/controllers/home/HomeController.dart';
import 'package:transfercrypto/controllers/transfer/TransferController.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:transfercrypto/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';
import '../data/enums.dart';
import '../utils/responsive_transfer_form_items.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/custom_button2.dart';
import '../widgets/custom_loader.dart';
import '../widgets/dropdown_button_list.dart';

class TransferFirstStep extends StatefulWidget {
  const TransferFirstStep({Key? key}) : super(key: key);

  @override
  State<TransferFirstStep> createState() => _TransferFirstStepState();
}

class _TransferFirstStepState extends State<TransferFirstStep> {
  @override
  void initState() {
    super.initState();
  }

  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var amountController = TextEditingController();
    var amountAfterFeeController = TextEditingController();
    var exchangeValueContoller = TextEditingController();

    double? amount;
    double? amountAfterFee;
    double? exchangeValue;

    if (Get.find<TransferController>().inputAmount != null) {
      debugPrint('inputAmount ${Get.find<TransferController>().inputAmount}');
      amount = Get.find<TransferController>().inputAmount;
      amountAfterFee = Get.find<TransferController>().inputAmountAfterFee;
      exchangeValue = Get.find<TransferController>().exchangeValue;
      amountController.text = '${amount}';
      amountAfterFeeController.text = '${amountAfterFee}';
      exchangeValueContoller.text = '${exchangeValue}';
    } else {
      debugPrint('inputAmount ${Get.find<TransferController>().inputAmount}');
      amountController.text = '';
      amountAfterFeeController.text = '';
      exchangeValueContoller.text = '';
    }

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Container(
        color: Colors.transparent,
        child: GetBuilder<TransferController>(builder: (controller) {
          return ResponsiveBuilder(builder: (context, sizingInformation) {
            return controller.methodValuesLoaded
                ? Stack(
                    children: [
                      Positioned(
                          left: 1,
                          top: 1,
                          child: Container(
                            width: 250,
                            height: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[50],
                                border: Border.all(color: Colors.transparent)),
                          )),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 25, left: 25, top: 15, bottom: 5),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        sizingInformation.deviceScreenType !=
                                                DeviceScreenType.mobile
                                            ? Expanded(
                                                child: Divider(
                                                  color:
                                                      AppColors.secondaryColor,
                                                ),
                                              )
                                            : SizedBox.shrink(),
                                        Expanded(
                                          child: Center(
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: sizingInformation
                                                              .deviceScreenType ==
                                                          DeviceScreenType
                                                              .mobile
                                                      ? 0
                                                      : 30),
                                              child: Text(
                                                'chooseAmountAndWallet'.tr,
                                                maxLines: 1,
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontSize: sizingInformation
                                                                .deviceScreenType ==
                                                            DeviceScreenType
                                                                .mobile
                                                        ? 18
                                                        : 20,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.primaryColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        sizingInformation.deviceScreenType !=
                                                DeviceScreenType.mobile
                                            ? Expanded(
                                                child: Divider(
                                                  color:
                                                      AppColors.secondaryColor,
                                                ),
                                              )
                                            : SizedBox.shrink()
                                      ]),
                                ),
                                50.height,
                                formItem(
                                    fieldTitle:
                                        'chooseWalletWhichYouWillTransferFrom'
                                            .tr,
                                    field2Title:
                                        'chooseWalletWhichYouWillTransferTo'.tr,
                                    sizingInformation: sizingInformation,
                                    autoFocusField: false,
                                    child1: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: AppColors.secondaryColor)),
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                            focusColor: Colors.transparent),
                                        child: CustomDropDownButtonList(
                                          value:
                                              controller.selectedTransferMethod,
                                          isReceive: false,
                                          list: controller.transferMethodsList,
                                          onChanged: (value) {
                                            controller.resetAllDetails(false);

                                            controller
                                                .setSelectedTransferMethod(
                                                    value!);
                                            controller.updateReceiveList();

                                            controller.updateValues();

                                            if (amount != null) {
                                              amountAfterFee = amount! -
                                                  amount! *
                                                      controller.selectedMethod!
                                                          .commission /
                                                      100;
                                              amountAfterFeeController.text =
                                                  '${amountAfterFee}';
                                              exchangeValue = int.parse(
                                                      homeController
                                                          .adminValuesList
                                                          .firstWhere((element) =>
                                                              element.key ==
                                                              'selling_price')
                                                          .value) *
                                                  amountAfterFee!;
                                              exchangeValueContoller.text =
                                                  '${exchangeValue}';
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    child2: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: AppColors.secondaryColor)),
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                            focusColor: Colors.transparent),
                                        child: CustomDropDownButtonList(
                                          value:
                                              controller.selectedReceiveMethod,
                                          isReceive: true,
                                          list: controller.receiveMethodsList,
                                          onChanged: (value) {
                                            controller.resetAllDetails(false);
                                            controller.setSelectedReceiveMethod(
                                                value!);
                                            controller.updateValues();
                                            int exchangePrice = 0;
                                            if (amount != null) {
                                              if (amount! >=
                                                      controller.selectedMethod!
                                                          .min_value &&
                                                  amount! <=
                                                      controller.selectedMethod!
                                                          .max_value) {
                                                amountAfterFee = amount! -
                                                    amount! *
                                                        controller
                                                            .selectedMethod!
                                                            .commission /
                                                        100;
                                                amountAfterFeeController.text =
                                                    '${amountAfterFee}';
                                                if (controller
                                                            .selectedTransferMethod!
                                                            .wallet_name ==
                                                        'cash' ||
                                                    controller
                                                            .selectedTransferMethod!
                                                            .wallet_name ==
                                                        'syriatel-money') {
                                                  debugPrint('hhhhhhh');

                                                  exchangePrice = int.parse(
                                                      homeController
                                                          .adminValuesList
                                                          .firstWhere((element) =>
                                                              element.key ==
                                                              'transfer_price')
                                                          .value);
                                                  exchangeValue =
                                                      exchangePrice * amount!;
                                                } else if (controller
                                                            .selectedReceiveMethod!
                                                            .wallet_name ==
                                                        'cash' ||
                                                    controller
                                                            .selectedReceiveMethod!
                                                            .wallet_name ==
                                                        'syriatel-money') {
                                                  debugPrint('nnn');
                                                  exchangePrice = int.parse(
                                                      homeController
                                                          .adminValuesList
                                                          .firstWhere((element) =>
                                                              element.key ==
                                                              'receive_price')
                                                          .value);
                                                  exchangeValue =
                                                      exchangePrice *
                                                          amountAfterFee!;
                                                }

                                                debugPrint(
                                                    'exxxx :: ${exchangeValue}');
                                                exchangeValueContoller.text =
                                                    '${exchangeValue}';
                                              } else {
                                                amountAfterFeeController.text =
                                                    '';
                                                amountController.text = '';
                                                exchangeValueContoller.text =
                                                    '';
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    )),
                                25.height,
                                formItem(
                                  fieldTitle: 'enterAmount'.tr,
                                  field2Title: 'amountWillBeAfterCutFee'.tr +
                                      ' ' +
                                      '${controller.selectedMethod!.commission}' +
                                      ' %',
                                  fieldController: amountController,
                                  field2Controller: amountAfterFeeController,
                                  disableConfirmTextField: true,
                                  sizingInformation: sizingInformation,
                                  textFieldType: TextFieldType.PHONE,
                                  text2FieldType: TextFieldType.PHONE,
                                  autoFocusField: false,
                                  fieldIcon: Icons.monetization_on_outlined,
                                  fieldKeyboardType: TextInputType.number,
                                  field2KeyboardType: TextInputType.number,
                                  autoValidateField:
                                      AutovalidateMode.onUserInteraction,
                                  isAmount: true,
                                  onChangedfield: (value) {
                                    if (value.onlyNumbers()) {
                                      double val = double.parse(value);
                                      amount = val;

                                      if (val >=
                                              controller
                                                  .selectedMethod!.min_value &&
                                          val <=
                                              controller
                                                  .selectedMethod!.max_value) {
                                        double valAfterFee = val -
                                            val *
                                                controller.selectedMethod!
                                                    .commission /
                                                100;
                                        amountAfterFee = valAfterFee;
                                        amountAfterFeeController.text =
                                            '${valAfterFee}';
                                        int exchangePrice = 0;
                                        if (controller.selectedTransferMethod!
                                                    .wallet_name ==
                                                'cash' ||
                                            controller.selectedTransferMethod!
                                                    .wallet_name ==
                                                'syriatel-money') {
                                          debugPrint('hhhhhhh');

                                          exchangePrice = int.parse(
                                              homeController.adminValuesList
                                                  .firstWhere((element) =>
                                                      element.key ==
                                                      'transfer_price')
                                                  .value);
                                          exchangeValue =
                                              exchangePrice * amount!;
                                        } else if (controller
                                                    .selectedReceiveMethod!
                                                    .wallet_name ==
                                                'cash' ||
                                            controller.selectedTransferMethod!
                                                    .wallet_name ==
                                                'syriatel-money') {
                                          debugPrint('nnn');
                                          exchangePrice = int.parse(
                                              homeController.adminValuesList
                                                  .firstWhere((element) =>
                                                      element.key ==
                                                      'receive_price')
                                                  .value);
                                          exchangeValue =
                                              exchangePrice * amountAfterFee!;
                                        }

                                        debugPrint('exxxx :: ${exchangeValue}');
                                        exchangeValueContoller.text =
                                            '${exchangeValue}';
                                      }
                                    }
                                  },
                                  validatorfield2: (value) {
                                    return null;
                                  },
                                  validatorfield: (value) {
                                    if (value.onlyNumbers()) {
                                      double val = double.parse(value!);

                                      if (val >=
                                              controller
                                                  .selectedMethod!.min_value &&
                                          val <=
                                              controller
                                                  .selectedMethod!.max_value) {
                                        return null;
                                      } else if (val <=
                                          controller
                                              .selectedMethod!.min_value) {
                                        return '${'amountMustBeAtLeast'.tr}  ${controller.selectedMethod!.min_value}';
                                      } else if (val >=
                                          controller
                                              .selectedMethod!.max_value) {
                                        return '${'amountMustBeAtMost'.tr}  ${controller.selectedMethod!.max_value}';
                                      }
                                    } else {
                                      amountController.text = '';
                                      return 'pleaseEnterOnlyNumbers'.tr;
                                    }
                                    return null;
                                  },
                                  addText: true,
                                  startAddText:
                                      '${'minAmountCouldBeTransfered'.tr}  ',
                                  middleAddText:
                                      '${controller.selectedMethod!.min_value}',
                                  endAddText: '',
                                  addText2: true,
                                  startAddText2:
                                      '${'maxAmountCouldBeTransfered'.tr}  ',
                                  middleAddText2:
                                      '${controller.selectedMethod!.max_value}',
                                  endAddText2: '',
                                ),
                                25.height,
                                (controller.selectedReceiveMethod!
                                                .wallet_name ==
                                            'cash' ||
                                        controller.selectedTransferMethod!
                                                .wallet_name ==
                                            'cash' ||
                                        controller.selectedReceiveMethod!
                                                .wallet_name ==
                                            'syriatel-money' ||
                                        controller.selectedTransferMethod!
                                                .wallet_name ==
                                            'syriatel-money')
                                    ? formItem(
                                        child2: SizedBox.shrink(),
                                        fieldTitle: 'exchangeValue'.tr,
                                        fieldController: exchangeValueContoller,
                                        disablePrimaryTextField: true,
                                        sizingInformation: sizingInformation,
                                        textFieldType: TextFieldType.PHONE,
                                        autoFocusField: false,
                                        fieldIcon: Icons.money_outlined,
                                        fieldKeyboardType: TextInputType.number,
                                        autoValidateField:
                                            AutovalidateMode.onUserInteraction,
                                        isAmount: false,
                                        onChangedfield: (value) {},
                                        addText: true,
                                        startAddText: '',
                                        middleAddText: '${'syrianBound'.tr}',
                                        endAddText: '',
                                        addText2: false,
                                        startAddText2: '',
                                        middleAddText2: '',
                                        endAddText2: '',
                                      )
                                    : SizedBox.shrink(),
                                50.height,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomButton2(
                                      text: 'nextStep'.tr,
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          controller.setAmount(amount!,
                                              amountAfterFee!, exchangeValue!);
                                          controller.nextPage();
                                        } else {
                                          showCustomSnackBar(
                                              'pleaseFillAllFields'.tr);
                                        }
                                      },
                                      backgroundColor: AppColors.primaryColor,
                                      textColor: AppColors.lightPurple,
                                      icon: Icons.arrow_forward_ios_rounded,
                                    ),
                                  ],
                                ),
                                5.height,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : CustomLoader();
          });
        }));
  }
}



//back button

 // Get.locale == Locale('en')
                //     ? Positioned(
                //         right: 15,
                //         top: 15,
                //         child: GestureDetector(
                //           onTap: () {
                //             Get.back();
                //           },
                //           child: HoverWidget(builder: (context, isHoviring) {
                //             return Container(
                //               width: 60,
                //               height: 40,
                //               alignment: Alignment.center,
                //               decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(10),
                //                   color: isHoviring
                //                       ? AppColors.secondaryColor
                //                       : AppColors.secondaryColor
                //                           .withOpacity(0.5),
                //                   border:
                //                       Border.all(color: Colors.transparent)),
                //               child: Text(
                //                 'back'.tr,
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                     fontSize: 18,
                //                     fontWeight: FontWeight.bold,
                //                     color: isHoviring
                //                         ? Colors.white
                //                         : AppColors.primaryColor),
                //               ),
                //             );
                //           }),
                //         ))
                //     : Positioned(
                //         left: 15,
                //         top: 15,
                //         child: GestureDetector(
                //           onTap: () {
                //             Get.back();
                //           },
                //           child: HoverWidget(builder: (context, isHoviring) {
                //             return Container(
                //               width: 60,
                //               height: 40,
                //               alignment: Alignment.center,
                //               decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(10),
                //                   color: isHoviring
                //                       ? AppColors.secondaryColor
                //                       : AppColors.secondaryColor
                //                           .withOpacity(0.5),
                //                   border:
                //                       Border.all(color: Colors.transparent)),
                //               child: Text(
                //                 'back'.tr,
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                     fontSize: 18,
                //                     fontWeight: FontWeight.bold,
                //                     color: isHoviring
                //                         ? Colors.white
                //                         : AppColors.primaryColor),
                //               ),
                //             );
                //           }),
                //         ))
