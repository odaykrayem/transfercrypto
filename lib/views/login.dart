import 'package:transfercrypto/extensions/hover_pointer_extinsion.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:transfercrypto/views/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/home/HomeController.dart';
import '../data/enums.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/custom_loader.dart';
import '../widgets/custom_text_filed.dart';
import 'enterEmail.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var emailController = TextEditingController();

    // emailController.text = '9999999999';
    // passwordController.text = '000000';

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    HomeController homeController = Get.find<HomeController>();

    void _submit(AuthController authController) {
      if (formKey.currentState!.validate()) {
        String email = emailController.text.trim();
        String password = passwordController.text.trim();

        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            if (Get.isDialogOpen == true) Get.back();

            // showCustomSnackBar(status.message);
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? ResponsiveBuilder(builder: (context, sizingInfo) {
                  return SingleChildScrollView(
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
                                    'login'.tr,
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
                                    'loginToYourAccount'.tr,
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
                            hintText: 'email'.tr,
                            prefixIcon: Icons.email,
                            autoFocus: true,
                            controller: emailController,
                          ),
                          20.height,
                          CustomTextField(
                            textFieldType: TextFieldType.PASSWORD,
                            hintText: 'password'.tr,
                            prefixIcon: Icons.password_sharp,
                            controller: passwordController,
                          ),
                          70.height,
                          //signin button
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
                                  'login'.tr,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ).showCursorOnHover,
                          5.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => {},
                                  text: 'forgotYourPassword?'.tr,
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
                                        ..onTap = () => {
                                              homeController.openDialog(
                                                  const EnterEmailPage())
                                            },
                                      text: ' ${'reset'.tr}',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: sizingInfo.deviceScreenType ==
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => {
                                          homeController
                                              .openDialog(const RegisterPage())
                                        },
                                  text: 'dontHaveAnAccount?'.tr,
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
                                        ..onTap = () => {
                                              homeController.openDialog(
                                                  const RegisterPage())
                                            },
                                      text: ' ${'register'.tr}',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: sizingInfo.deviceScreenType ==
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
                          )
                        ],
                      ),
                    ),
                  );
                })
              : const CustomLoader();
        }));
  }
}
