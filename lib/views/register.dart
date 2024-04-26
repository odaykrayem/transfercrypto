import 'package:transfercrypto/controllers/home/HomeController.dart';
import 'package:transfercrypto/extensions/hover_pointer_extinsion.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';
import '../controllers/auth/auth_controller.dart';
import '../data/enums.dart';
import '../models/signup_body_model.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/custom_loader.dart';
import '../widgets/custom_text_filed.dart';
import 'login.dart';
import 'otp.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var firstNameController = TextEditingController();
    var lastNameController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    HomeController homeController = Get.find<HomeController>();
    // emailController.text = 'email@gmail.com';
    // passwordController.text = '000000';
    // confirmPasswordController.text = '000000';
    // firstNameController.text = 'ooo';
    // lastNameController.text = 'ooo';

    void _submit(AuthController authController) {
      if (formKey.currentState!.validate()) {
        String firstName = firstNameController.text.trim();
        String lastName = lastNameController.text.trim();
        String email = emailController.text.trim();
        String password = passwordController.text.trim();
        String confirmPassword = confirmPasswordController.text.trim();

        RegExp emailReg = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

        if (firstName.isEmpty) {
          showCustomSnackBar('typeInYourFirstName'.tr, title: 'name'.tr);
        } else if (firstName.length < 3) {
          showCustomSnackBar('firstNameMustBeThree'.tr,
              title: 'invalidFirstName'.tr);
        } else if (lastName.isEmpty) {
          showCustomSnackBar('typeInYourLastName'.tr, title: 'name'.tr);
        } else if (lastName.length < 3) {
          showCustomSnackBar('lastNameMustBeThree'.tr,
              title: 'invalidLastName'.tr);
        } else if (email.isEmpty) {
          showCustomSnackBar('typeInYourEmail'.tr, title: 'email'.tr);
        } else if (!emailReg.hasMatch(email.trim())) {
          showCustomSnackBar("${'emailMustBeLike'.tr} example@something.com",
              title: 'invalidEmail'.tr);
        } else if (password.isEmpty) {
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
          // showCustomSnackBar('perfect'.tr, title: 'perfect'.tr);
          SignUpBody signUpBody = SignUpBody(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
          );
          authController.setSignupBody(signUpBody);
          authController.register().then((status) {
            if (status.isSuccess) {
              authController.requestOtp(email);
              homeController.openDialog(OtpPage(
                email: email,
                isRegisterProcess: true,
              ));
              showCustomSnackBar('registerSuccess'.tr);
            } else {
              showCustomSnackBar(status.message);
              debugPrint(status.message);
            }
          });
          debugPrint(signUpBody.toString());
        }
      }
    }

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? ResponsiveBuilder(builder: (context, sizingInformation) {
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
                                    'register'.tr,
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
                                    'registerNewAccount'.tr,
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
                            textFieldType: TextFieldType.NAME,
                            controller: firstNameController,
                            hintText: 'firstName'.tr,
                            prefixIcon: Icons.person_pin_outlined,
                            autoFocus: true,
                          ),
                          20.height,
                          CustomTextField(
                            textFieldType: TextFieldType.NAME,
                            controller: lastNameController,
                            hintText: 'lastName'.tr,
                            prefixIcon: Icons.person_pin,
                            autoFocus: true,
                          ),
                          20.height,
                          CustomTextField(
                            textFieldType: TextFieldType.EMAIL,
                            controller: emailController,
                            hintText: 'email'.tr,
                            prefixIcon: Icons.email,
                            autoFocus: true,
                          ),
                          20.height,
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
                                  'register'.tr,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ).showCursorOnHover,
                          50.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => {
                                          homeController
                                              .openDialog(const LoginPage())
                                        },
                                  text: 'alreadyHaveAnAccount?'.tr,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize:
                                        sizingInformation.deviceScreenType ==
                                                DeviceScreenType.mobile
                                            ? 14
                                            : 18,
                                  ),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => {
                                              homeController
                                                  .openDialog(const LoginPage())
                                            },
                                      text: ' ${'login'.tr}',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: sizingInformation
                                                    .deviceScreenType ==
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
