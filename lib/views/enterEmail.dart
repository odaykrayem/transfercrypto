// ignore_for_file: file_names
import 'package:transfercrypto/controllers/home/HomeController.dart';
import 'package:transfercrypto/extensions/hover_pointer_extinsion.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../controllers/auth/auth_controller.dart';
import '../data/enums.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/custom_loader.dart';
import '../widgets/custom_text_filed.dart';
import 'otp.dart';

class EnterEmailPage extends StatelessWidget {
  const EnterEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    HomeController homeController = Get.find<HomeController>();

    void _submit(AuthController authController) {
      if (formKey.currentState!.validate()) {
        String email = emailController.text.trim();

        RegExp emailReg = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

        if (email.isEmpty) {
          showCustomSnackBar('typeInYourEmail'.tr, title: 'email'.tr);
        } else if (!emailReg.hasMatch(email.trim())) {
          showCustomSnackBar("${'emailMustBeLike'.tr} example@something.com",
              title: 'invalidEmail'.tr);
        } else {
          authController.requestOtp(email);
          homeController.openDialog(OtpPage(
            email: email,
            isRegisterProcess: false,
          ));
        }
      }
    }

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  // physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'resetPassword'.tr,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'enterEmailToSendTheCode'.tr,
                                  style: TextStyle(
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ]),
                        ),
                        50.height,
                        CustomTextField(
                          textFieldType: TextFieldType.EMAIL,
                          controller: emailController,
                          hintText: 'email'.tr,
                          prefixIcon: Icons.email,
                          autoFocus: true,
                        ),
                        70.height,
                        GestureDetector(
                          onTap: () {
                            _submit(authController);
                          },
                          child: Container(
                            // width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                'submit'.tr,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ).showCursorOnHover,
                        50.height,
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     RichText(
                        //       text: TextSpan(
                        //         text: 'alreadyHaveAnAccount?'.tr,
                        //         style: TextStyle(
                        //           color: Colors.grey[500],
                        //           fontSize: 18,
                        //         ),
                        //         children: [
                        //           TextSpan(
                        //             recognizer: TapGestureRecognizer()
                        //               ..onTap = () => {
                        //                     homeController
                        //                         .openDialog(const LoginPage())
                        //                   },
                        //             text: ' ${'login'.tr}',
                        //             style: const TextStyle(
                        //               color: AppColors.primaryColor,
                        //               fontSize: 18,
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                )
              : const CustomLoader();
        }));
  }
}
