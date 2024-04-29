import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transfercrypto/controllers/home/HomeController.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transfercrypto/routes/routes.dart';
import 'package:transfercrypto/widgets/custom_gesture.dart';
import '../constants/app_colors.dart';
import '../data/nav_items_list.dart';
import 'custom_nav_button.dart';
import 'navbar_item.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key, this.navBarHeight = 100});
  final Color backgroundColor = AppColors.primaryColor;
  final double navBarHeight;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<HomeController>(() => HomeController(repo: Get.find()));
    HomeController homeController = Get.find<HomeController>();
    // AuthController authController = Get.find<AuthController>();

    return Directionality(
      textDirection: TextDirection.ltr,
      child: ScreenTypeLayout.builder(
        mobile: (_) => navBarMobile(homeController),
        tablet: (_) => navBarMobile(homeController),
        desktop: (_) => navBarTabletDesktop(homeController),
      ),
    );
  }

  Widget navBarTabletDesktop(HomeController homeController) {
    return CustomGesture(
      child: Container(
        height: navBarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            navBarLogo(),
            Container(
              child: GetBuilder<HomeController>(builder: (controller) {
                return Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: controller.userLoggedIn
                      ? [
                          ...navigationItemsList.map(
                            (e) => Row(
                              children: [
                                NavBarItem(
                                  model: e,
                                ),
                                const SizedBox(
                                  width: 60,
                                ),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                onPressed: () {
                                  Get.toNamed(Routes.getProfile());
                                },
                                color: Colors.white,
                                icon: Icon(
                                  Icons.person,
                                  color: AppColors.primaryColor,
                                )),
                          ),
                        ]
                      : [
                          CustomNavButton(
                            title: 'login'.tr,
                            onButtonPressed: () {
                              Get.toNamed(Routes.login);
                              // homeController.openDialog(LoginPage());
                            },
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          CustomNavButton(
                            title: 'register'.tr,
                            onButtonPressed: () {
                              Get.toNamed(Routes.signup);
                              // homeController.openDialog(RegisterPage());
                            },
                          ),
                        ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget navBarMobile(HomeController homeController) {
    return Container(
      color: backgroundColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              CupertinoIcons.line_horizontal_3_decrease,
              color: Colors.white,
            ),
            onPressed: () {
              homeController.openDrawer();
            },
          ),
          navBarLogo()
        ],
      ),
    );
  }

  Widget navBarLogo() {
    return SizedBox(
      width: 150,
      child:
          // Text('')
          Image.asset(
        'assets/images/logo128.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
