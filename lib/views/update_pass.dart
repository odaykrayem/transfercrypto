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
import 'login.dart';

class UpdatePass extends StatelessWidget {
  const UpdatePass({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    HomeController homeController = Get.find<HomeController>();
    passwordController.text = '000000';
    confirmPasswordController.text = '000000';

    void _submit(AuthController authController) {
      if (formKey.currentState!.validate()) {
        String password = passwordController.text.trim();
        String confirmPassword = confirmPasswordController.text.trim();

        if (password.isEmpty) {
          showCustomSnackBar('typeInYourPassword'.tr, title: 'password'.tr);
        } else if (password.length < 6) {
          showCustomSnackBar('passwordCanNotBeLessThanSixCharacters'.tr,
              title: 'invalidPassword'.tr);
        } else if (confirmPassword.isEmpty) {
          showCustomSnackBar('typeInPasswordConfirmation'.tr,
              title: 'password'.tr);
        } else if (password != confirmPassword) {
          showCustomSnackBar('passwordAndPasswordConfirmationAreNotTheSame'.tr,
              title: 'password'.tr);
        } else {
          authController.updatePassword(email, password).then((status) {
            if (status.isSuccess) {
              debugPrint('success update pass');
              homeController.openDialog(LoginPage());
              showCustomSnackBar('passwordUpdatedSuccessfully'.tr);
            } else {
              showCustomSnackBar(status.message);
              debugPrint(status.message);
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
                                Text(
                                  'enterNewePassword'.tr,
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
                          textFieldType: TextFieldType.PASSWORD,
                          controller: passwordController,
                          hintText: 'password'.tr,
                          prefixIcon: Icons.password_sharp,
                        ),
                        20.height,
                        CustomTextField(
                          textFieldType: TextFieldType.PASSWORD,
                          controller: confirmPasswordController,
                          hintText: 'confirmPassword'.tr,
                          prefixIcon: Icons.password,
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
                                'updatePassword'.tr,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ).showCursorOnHover,
                      ],
                    ),
                  ),
                )
              : CustomLoader();
        }));
  }
}
