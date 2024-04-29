import 'package:transfercrypto/data/repository/user_repo.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transfercrypto/views/auth_template.dart';
import '../constants/app_colors.dart';
import '../controllers/home/HomeController.dart';
import '../controllers/user/user_controller.dart';
import '../data/repository/home_repo.dart';
import '../widgets/custom_loader.dart';
import '../widgets/custom_nav_button.dart';
import '../widgets/hover_widget.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<UserController>(() => UserController(repo: Get.find()));
    Get.lazyPut<UserRepo>(() => UserRepo(apiClient: Get.find()));

    Get.lazyPut<HomeController>(() => HomeController(repo: Get.find()));
    Get.lazyPut<HomeRepo>(() => HomeRepo(apiClient: Get.find()));
    return AuthTemplate(
      isProfile: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GetBuilder<UserController>(builder: (controller) {
          return (Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'profile'.tr,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
              ),
              controller.loaded
                  ? !controller.isErrorLoadingInfo
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              rowWidget(
                                title: '',
                                content:
                                    '${controller.userModel!.firstName}  ${controller.userModel!.lastName}',
                                icon1: Icons.person_pin_rounded,
                                icon1Color: Colors.white,
                              ),
                              35.height,
                              rowWidget(
                                title: '',
                                content: '${controller.userModel!.email}',
                                icon1: Icons.alternate_email,
                                icon1Color: Colors.white,
                              ),
                              35.height,
                              rowWidget(
                                  title: '',
                                  content: 'changelanguage'.tr,
                                  icon1: Icons.translate_rounded,
                                  icon1Color: Colors.white,
                                  child2: HoverWidget(
                                      builder: (context, isHoviring) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: isHoviring
                                            ? Colors.white
                                            : AppColors.secondaryColor
                                                .withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        'changeLangauge'.tr,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: isHoviring
                                                ? AppColors.secondaryColor
                                                : Colors.white),
                                      ),
                                    );
                                  }),
                                  onTap: () {
                                    controller.changeLanguage();
                                  }),
                              30.height,
                            ],
                          ),
                        )
                      : const Text('Connection Error')
                  : const CustomLoader(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomNavButton(
                      firstColor: Colors.white,
                      secondColor: AppColors.primaryColor,
                      onButtonPressed: () {
                        debugPrint("logouttt");
                        controller.logout();
                      },
                      title: 'logout'.tr,
                    ),
                  )
                ],
              )
            ],
          ));
        }),
      ),
    );
  }

  Widget rowWidget({
    required String? title,
    required String content,
    IconData? icon1,
    Color? icon1Color,
    String? image2,
    Widget? child2,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    icon1 != null
                        ? CircleAvatar(
                            backgroundColor:
                                AppColors.secondaryColor.withOpacity(0.6),
                            child: Icon(
                              icon1,
                              color: icon1Color,
                            ),
                          )
                        : SizedBox.shrink(),
                    (icon1 != null && title != null) ? 5.width : 0.width,
                    title != null
                        ? Expanded(
                            child: Text(
                              title,
                              softWrap: true,
                              style: TextStyle(
                                  color: AppColors.primaryColor, fontSize: 16),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(8),
                child: child2 ??
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            content,
                            softWrap: true,
                            style:
                                TextStyle(color: Colors.black87, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
