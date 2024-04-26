import 'package:transfercrypto/extensions/hover_pointer_extinsion.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:transfercrypto/views/update_pass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/home/HomeController.dart';
import '../data/enums.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/custom_loader.dart';
import '../widgets/custom_text_filed.dart';
import 'login.dart';

class OtpPage extends StatelessWidget {
  const OtpPage(
      {Key? key, required this.email, required this.isRegisterProcess})
      : super(key: key);
  final bool isRegisterProcess;
  final String email;

  @override
  Widget build(BuildContext context) {
    var codeController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    HomeController homeController = Get.find<HomeController>();

    void _verify(AuthController authController) {
      if (formKey.currentState!.validate()) {
        String code = codeController.text.trim();
        if (code.length < 6) {
          showCustomSnackBar('codeMustBeSixNumbers'.tr,
              title: 'verificationCode'.tr);
        } else {
          authController.verifyOTP(email, code).then((status) {
            if (status.isSuccess) {
              isRegisterProcess
                  ? homeController.openDialog(LoginPage())
                  : homeController.openDialog(UpdatePass(
                      email: email,
                    ));
            } else {
              showCustomSnackBar('otpWrong'.tr);
            }
          });
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
                                50.height,
                                Text(
                                  'pleaseTypeInTheCodeSentToYourEmail'.tr,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor),
                                ),
                              ]),
                        ),
                        50.height,
                        CustomTextField(
                          textFieldType: TextFieldType.OTHER,
                          hintText: '******',
                          prefixIcon: Icons.numbers,
                          autoFocus: true,
                          controller: codeController,
                        ),

                        70.height,
                        //signin button
                        GestureDetector(
                          onTap: () {
                            _verify(authController);
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
                                'verify'.tr,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ).showCursorOnHover,
                        50.height,
                      ],
                    ),
                  ),
                )
              : CustomLoader();
        }));
  }
}
