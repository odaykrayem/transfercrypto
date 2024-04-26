import 'package:transfercrypto/controllers/transfer/TransferController.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';
import '../controllers/auth/auth_controller.dart';
import '../data/enums.dart';
import '../utils/responsive_transfer_form_items.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/custom_button2.dart';
import '../widgets/custom_loader.dart';

class TransferSecondStep extends StatefulWidget {
  const TransferSecondStep({Key? key}) : super(key: key);

  @override
  State<TransferSecondStep> createState() => _TransferSecondStepState();
}

class _TransferSecondStepState extends State<TransferSecondStep> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var fullNameController = TextEditingController();
    var userWalletIdController = TextEditingController();
    var cityController = TextEditingController();

    String? userEmail, userPhone, userFullName, userCity, userWalletId;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TransferController transferController =
        Get.find<TransferController>();
    // transferController.setSecondStepDetails(
    //   userEmail: 'email@email.com',
    //   userCity: 'مدينة',
    //   userFullName: 'احمد احمد احمد',
    //   userPhone: '0938477326',
    //   userWalletId: 'P10293873636',
    // );
    if (transferController.inputUserEmail == null) {
      userEmail = Get.find<AuthController>().getUserEmail();
      transferController.setInputUserEmail(userEmail: userEmail);
      emailController.text = userEmail;
    } else {
      userEmail = transferController.inputUserEmail;
      emailController.text = userEmail ?? '';
    }

    userPhone = transferController.inputUserPhone;
    phoneController.text = userPhone ?? '';
    userFullName = transferController.inputUserFullName;
    fullNameController.text = userFullName ?? '';
    userCity = transferController.inputUserCity;
    cityController.text = userCity ?? '';
    userWalletId = transferController.inputUserWalletId;
    userWalletIdController.text = userWalletId ?? '';
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
                                              'yourDetails'.tr,
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
                                              : SizedBox.shrink(),
                                        ]),
                                  ),
                                  50.height,
                                  formItem(
                                      fieldTitle: 'yourEmail'.tr,
                                      field2Title: (controller
                                                      .selectedReceiveMethod!
                                                      .wallet_name ==
                                                  'cash' ||
                                              controller.selectedTransferMethod!
                                                      .wallet_name ==
                                                  'cash')
                                          ? 'enterYourPhoneConsistOf10DigitsAndBeginWith09'
                                              .tr
                                          : '',
                                      sizingInformation: sizingInformation,
                                      autoFocusField: true,
                                      fieldController: emailController,
                                      field2Controller: phoneController,
                                      textFieldType: TextFieldType.EMAIL,
                                      text2FieldType: TextFieldType.PHONE,
                                      fieldIcon: Icons.mark_email_read_outlined,
                                      field2Icon: Icons.phone,
                                      child2: (controller.selectedReceiveMethod!
                                                      .wallet_name ==
                                                  'cash' ||
                                              controller.selectedTransferMethod!
                                                      .wallet_name ==
                                                  'cash')
                                          ? null
                                          : SizedBox.shrink()),
                                  25.height,
                                  controller.selectedReceiveMethod!
                                              .wallet_name ==
                                          'cash'
                                      ? formItem(
                                          fieldTitle:
                                              'enterYourFullNameAsItOnId'.tr,
                                          field2Title: 'enterYourCityName'.tr,
                                          autoFocusField: false,
                                          sizingInformation: sizingInformation,
                                          fieldController: fullNameController,
                                          field2Controller: cityController,
                                          textFieldType: TextFieldType.NAME,
                                          text2FieldType: TextFieldType.NAME,
                                          fieldIcon:
                                              Icons.perm_identity_rounded,
                                          field2Icon: Icons.place_outlined)
                                      : SizedBox.shrink(),
                                  25.height,
                                  controller.selectedReceiveMethod!.wallet_name !=
                                          'cash'
                                      ? formItem(
                                          fieldTitle: 'enterYourAccountId'.tr +
                                              '  ' +
                                              '${controller.selectedReceiveMethod!.wallet_name}',
                                          field2Title: ''.tr,
                                          autoFocusField: false,
                                          sizingInformation: sizingInformation,
                                          fieldController:
                                              userWalletIdController,
                                          textFieldType: TextFieldType.NAME,
                                          fieldIcon: Icons
                                              .account_balance_wallet_rounded,
                                          child2: SizedBox.shrink())
                                      : SizedBox.shrink(),
                                  50.height,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomButton2(
                                        text: 'back'.tr,
                                        onTap: () {
                                          userEmail = emailController.text;
                                          userCity = cityController.text;
                                          userFullName =
                                              fullNameController.text;
                                          userPhone = phoneController.text;
                                          userWalletId =
                                              userWalletIdController.text;
                                          controller.setSecondStepDetails(
                                            userEmail: userEmail,
                                            userCity: userCity,
                                            userFullName: userFullName,
                                            userPhone: userPhone,
                                            userWalletId: userWalletId,
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
                                        text: 'nextStep'.tr,
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            userEmail = emailController.text;
                                            userCity = cityController.text;
                                            userFullName =
                                                fullNameController.text;
                                            userPhone = phoneController.text;
                                            userWalletId =
                                                userWalletIdController.text;
                                            controller.setSecondStepDetails(
                                              userEmail: userEmail!,
                                              userCity: userCity,
                                              userFullName: userFullName,
                                              userPhone: userPhone,
                                              userWalletId: userWalletId,
                                            );
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
