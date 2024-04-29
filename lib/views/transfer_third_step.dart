import 'dart:io';
import 'dart:math';
import 'package:transfercrypto/controllers/transfer/TransferController.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';
import '../controllers/home/HomeController.dart';
import '../data/enums.dart';
import '../utils/responsive_transfer_form_items.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/custom_button2.dart';
import '../widgets/custom_loader.dart';

class TransferThirdStep extends StatefulWidget {
  const TransferThirdStep({Key? key}) : super(key: key);

  @override
  State<TransferThirdStep> createState() => _TransferThirdStepState();
}

class _TransferThirdStepState extends State<TransferThirdStep> {
  @override
  void initState() {
    Get.find<TransferController>().getAdminValueMap();

    super.initState();
  }

  late TextEditingController userOperationCodeController;
  File? userReceiptImage;
  XFile? pickedFile;
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    userOperationCodeController = TextEditingController();
    String? userOperationCode;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TransferController transferController =
        Get.find<TransferController>();
    // transferController.setThirdStepDetails(
    //     userOperationCode: 'Idsdkkjjjsdhhh',
    //     userReceiptImage: transferController.userReceiptImage);
    userOperationCode = transferController.inputUserOperationCode;
    userOperationCodeController.text = userOperationCode ?? '';
    debugPrint('userRImage :: ${transferController.userReceiptImage == null}');
    pickedFile = transferController.userReceiptImage;

    void _submit(TransferController controller, bool isCTW) async {
      Uint8List? imageData;
      if (isCTW) {
        imageData = await pickedFile!.readAsBytes();
      }
      controller.addTransaction(isCTW, imageData).then((response) {
        if (response.isSuccess) {
          showCustomSnackBar('successOperation'.tr, isError: false, title: '');
          controller.resetAllDetails(true);
          controller.pageViewController.dispose();
          Get.find<HomeController>().changePage(0);
        } else {
          showCustomSnackBar(response.message,
              isError: true, title: 'error'.tr);
        }
      });
    }

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
                        child: SingleChildScrollView(
                          // physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 25, left: 25, top: 15, bottom: 5),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          sizingInformation.deviceScreenType !=
                                                  DeviceScreenType.mobile
                                              ? Expanded(
                                                  child: Divider(
                                                    color: AppColors
                                                        .secondaryColor,
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              'exchangeConfirmation'.tr,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: sizingInformation
                                                              .deviceScreenType ==
                                                          DeviceScreenType
                                                              .mobile
                                                      ? 17
                                                      : 20,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                          ),
                                          sizingInformation.deviceScreenType !=
                                                  DeviceScreenType.mobile
                                              ? Expanded(
                                                  child: Divider(
                                                    color: AppColors
                                                        .secondaryColor,
                                                  ),
                                                )
                                              : SizedBox.shrink()
                                        ]),
                                  ),
                                  !controller
                                          .selectedTransferMethod!.wallet_name
                                          .contains('cash')
                                      ? wtwAndwtc(controller, sizingInformation)
                                      : ctw(controller, sizingInformation),
                                  50.height,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomButton2(
                                        text: 'back'.tr,
                                        onTap: () {
                                          userOperationCode =
                                              userOperationCodeController.text;
                                          controller.setThirdStepDetails(
                                            userOperationCode:
                                                userOperationCode,
                                            userReceiptImage: pickedFile,
                                          );

                                          controller.previousPage();
                                        },
                                        backgroundColor: AppColors.lightPurple,
                                        textColor: AppColors.primaryColor,
                                        icon: Icons.arrow_back_ios_rounded,
                                        iconColor: AppColors.primaryColor,
                                        iconBeforeText: true,
                                      ),
                                      CustomButton2(
                                        text: 'confirm'.tr,
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            userOperationCode =
                                                userOperationCodeController
                                                    .text;
                                            controller.setThirdStepDetails(
                                              userOperationCode:
                                                  userOperationCode,
                                              userReceiptImage: pickedFile,
                                            );
                                            if (controller
                                                .selectedTransferMethod!
                                                .wallet_name
                                                .contains('cash')) {
                                              if (pickedFile == null) {
                                                showCustomSnackBar(
                                                    'pleaseChooseReceiptImage'
                                                        .tr);
                                              } else {
                                                Get.defaultDialog(
                                                    textCancel: 'noEdit'.tr,
                                                    textConfirm:
                                                        'yesIamSure'.tr,
                                                    title: '',
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            50),
                                                    titlePadding:
                                                        const EdgeInsets.all(0),
                                                    middleText:
                                                        'areYouSureAboutInfoYouEntered'
                                                            .tr,
                                                    cancelTextColor:
                                                        Colors.red[200],
                                                    confirmTextColor:
                                                        Colors.white,
                                                    onConfirm: () {
                                                      _submit(controller, true);
                                                      Get.back();
                                                    },
                                                    onCancel: () {});
                                              }
                                            } else {
                                              Get.defaultDialog(
                                                  textCancel: 'noEdit'.tr,
                                                  textConfirm: 'yesIamSure'.tr,
                                                  title: '',
                                                  contentPadding:
                                                      const EdgeInsets.all(50),
                                                  titlePadding:
                                                      const EdgeInsets.all(0),
                                                  middleText:
                                                      'areYouSureAboutInfoYouEntered'
                                                          .tr,
                                                  cancelTextColor:
                                                      Colors.red[200],
                                                  confirmTextColor:
                                                      Colors.white,
                                                  onConfirm: () {
                                                    _submit(controller, false);
                                                    Get.back();
                                                  },
                                                  onCancel: () {});
                                            }
                                          } else {
                                            showCustomSnackBar(
                                                'pleaseFillAllFields'.tr);
                                          }
                                        },
                                        backgroundColor: AppColors.primaryColor,
                                        textColor: AppColors.lightPurple,
                                        icon: Icons.done_outline_rounded,
                                      ),
                                    ],
                                  ),
                                  5.height,
                                ],
                              ),
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

  Widget wtwAndwtc(
      TransferController controller, SizingInformation sizingInformation) {
    return Column(
      children: [
        formItem(
            fieldTitle: Get.locale != Locale('ar')
                ? '${'our'.tr} ${controller.selectedMethod!.admin_wallet_name}  ${'accountDetails'.tr}'
                : '${'accountDetails'.tr} ${controller.selectedMethod!.admin_wallet_name} ${'our'.tr} ',
            field2Title: 'ourAccountId'.tr,
            sizingInformation: sizingInformation,
            child1: Container(
                child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${'pleaseMakePaymentToOurAccountAndEnterYourPaymentDetailsInTheRelatedField'.tr}',
                    softWrap: true,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            )),
            child2: Container(
                child: Row(
              children: [
                Expanded(
                  child: SelectableText(
                    '${controller.selectedMethod!.admin_wallet_code}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(
                        text: '${controller.selectedMethod!.admin_wallet_code}',
                      ),
                    );
                    showCustomSnackBar('codeCoppied'.tr, isError: false);
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.secondaryColor.withOpacity(0.5),
                    child: const Icon(
                      Icons.copy,
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
              ],
            ))),
        25.height,
        formItem(
            fieldTitle: 'enterPaymentCodeThatYouDid'.tr,
            field2Title: ''.tr,
            autoFocusField: false,
            sizingInformation: sizingInformation,
            fieldController: userOperationCodeController,
            textFieldType: TextFieldType.NAME,
            fieldIcon: Icons.payment,
            child2: SizedBox.shrink())
      ],
    );
  }

  Widget ctw(
      TransferController controller, SizingInformation sizingInformation) {
    return Column(
      children: [
        formItem(
            fieldTitle:
                '${'transferMoneyAsCashByHaramAndAddTranferReceiptInTheFieldBelow'.tr}   ',
            field2Title: '${'ourTransferInfo'.tr} ',
            sizingInformation: sizingInformation,
            child1: const SizedBox.shrink(),
            child2: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        adminInfoItem(
                            'recieverName'.tr,
                            '${controller.adminValueMap['first_name']} ${controller.adminValueMap['middle_name']} ${controller.adminValueMap['last_name']}',
                            sizingInformation),
                        7.height,
                        adminInfoItem(
                            'receiverCity'.tr,
                            '${controller.adminValueMap['place']}',
                            sizingInformation),
                        7.height,
                        adminInfoItem(
                            'receiverPhone'.tr,
                            '${controller.adminValueMap['phone']}',
                            sizingInformation),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: '${'recieverName'.tr} : ${controller.adminValueMap['first_name']} ${controller.adminValueMap['middle_name']} ${controller.adminValueMap['last_name']} , \n' +
                                '${'receiverCity'.tr} : ${controller.adminValueMap['place']} ,\n' +
                                '${'receiverPhone'.tr} : ${controller.adminValueMap['phone']}.',
                          ),
                        );
                        showCustomSnackBar('infoCopied'.tr, isError: false);
                      },
                      child: CircleAvatar(
                        backgroundColor:
                            AppColors.secondaryColor.withOpacity(0.5),
                        child: const Icon(
                          Icons.copy,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
        25.height,
        formItem(
            fieldTitle: 'chooseReceiptImage'.tr,
            field2Title: '',
            sizingInformation: sizingInformation,
            autoFocusField: false,
            child1: Container(
              child: (!controller.receiptImageSelected ||
                      controller.userReceiptImage == null)
                  ? Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          _getFromGallery(controller);
                        },
                        child: Text('pickReceiptImage'.tr),
                      ),
                    )
                  : Column(
                      children: [
                        GetBuilder<TransferController>(builder: (controller) {
                          return Container(
                              child: ImageNetwork(
                            key: ValueKey(Random().nextInt(100)),
                            height: 300,
                            width: 300,
                            fitAndroidIos: BoxFit.contain,
                            fitWeb: BoxFitWeb.cover,
                            image: controller.userReceiptImagePath!,
                          ));
                        }),
                        10.height,
                        Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              _getFromGallery(controller);
                            },
                            child: Text('pickReceiptImage'.tr),
                          ),
                        )
                      ],
                    ),
            ),
            child2: SizedBox.shrink()),
      ],
    );
  }

  Widget adminInfoItem(
      String title, String subTitle, SizingInformation sizingInformation) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize:
                sizingInformation.deviceScreenType == DeviceScreenType.mobile
                    ? 16
                    : 18,
            // color: Colors.grey[700],
            color: AppColors.primaryColor,
          ),
        ),
        5.width,
        Container(
          alignment: Alignment.center,
          child: Text(
            subTitle,
            softWrap: true,
            style: TextStyle(
              fontSize:
                  sizingInformation.deviceScreenType == DeviceScreenType.mobile
                      ? 14
                      : 16,
              // color: Colors.grey[700],
              color: AppColors.secondaryColor,
            ),
          ),
          // SelectableText(
          //   subTitle,
          //   style: TextStyle(
          //     fontSize: 16,
          //     // color: Colors.grey[700],
          //     color: AppColors.secondaryColor,
          //   ),
          // ),
        )
      ],
    );
  }

  _getFromGallery(TransferController controller) async {
    pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      debugPrint('image picked1');
      userReceiptImage = File(pickedFile!.path);
      imagePath = pickedFile!.path;
      controller.setReceiptImageSelected(
          true, pickedFile!, userReceiptImage!.path);
    }
  }
}
