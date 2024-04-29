import 'package:flutter/gestures.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:transfercrypto/views/auth_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transfercrypto/widgets/custom_gesture.dart';
import '../constants/app_colors.dart';
import '../controllers/auth/auth_controller.dart';
import '../data/enums.dart';
import '../routes/routes.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/custom_loader.dart';
import '../widgets/custom_text_filed.dart';

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
                  ? Get.offNamed(Routes.getLogin())
                  : Get.offNamed(Routes.getUpdatePass(email));
            } else {
              showCustomSnackBar('otpWrong'.tr);
            }
          });
        }
      }
    }

    return AuthTemplate(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GetBuilder<AuthController>(builder: (authController) {
            return !authController.isLoading
                ? ResponsiveBuilder(builder: (context, sizingInfo) {
                    return SingleChildScrollView(
                      // physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      50.height,
                                      Text(
                                        'pleaseTypeInTheCodeSentToYourEmail'.tr,
                                        maxLines: 2,
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
                              CustomGesture(
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
                              ),
                              10.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => {},
                                      text: 'haventRecievedACode?'.tr,
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: sizingInfo.deviceScreenType ==
                                                DeviceScreenType.mobile
                                            ? 14
                                            : 18,
                                      ),
                                      children: [
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => authController
                                                .requestOtp(email),
                                          text: ' ${'resend'.tr}',
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize:
                                                sizingInfo.deviceScreenType ==
                                                        DeviceScreenType.mobile
                                                    ? 14
                                                    : 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              50.height,
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                : CustomLoader();
          })),
    );
  }
}
