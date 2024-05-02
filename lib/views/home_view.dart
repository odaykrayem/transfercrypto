import 'package:transfercrypto/controllers/home/HomeController.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transfercrypto/routes/routes.dart';
import '../constants/app_values.dart';
import '../widgets/custom_button.dart';
import 'details_section.dart';
import 'login.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final String homeDetailsTitle = AppValues.homeTitle;
  final String homeDetailsContent = AppValues.homeContent;
  final String homeButtonText = AppValues.homeButtonText;
  final String homeImage = 'assets/images/transfer_1.png';
  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ScreenTypeLayout.builder(
        mobile: (_) => homeMobile(),
        desktop: (_) => homeDesktop(),
        tablet: (_) => homeMobile(),
      ),
    );
  }

  Widget homeMobile() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          40.height,
          Image.asset(
            homeImage,
            width: 150,
            height: 150,
          ),
          40.height,
          DetailsSection(
            title: homeDetailsTitle.tr,
            content: homeDetailsContent.tr,
          ),
          30.height,
          CustomButton(
            title: homeButtonText.tr,
            onTap: () {
              _homeController.isLoggedIn()
                  ? _homeController.changePage(3)
                  : Get.toNamed(Routes.login);
              // : _homeController.openDialog(const LoginPage());
            },
          ),
          50.height
        ],
      ),
    );
  }

  Widget homeDesktop() {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            child: Stack(
              children: [
                Positioned(
                    top: 10,
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      homeImage,
                    )),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DetailsSection(
                title: homeDetailsTitle.tr,
                content: homeDetailsContent.tr,
              ),
              Center(
                child: CustomButton(
                  title: homeButtonText.tr,
                  onTap: () {
                    debugPrint('ooooo');
                    _homeController.isLoggedIn()
                        ? _homeController.changePage(3)
                        : _homeController.openDialog(const LoginPage());
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
