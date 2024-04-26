import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transfercrypto/controllers/home/HomeController.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';
import '../models/navbar_item_model.dart';

class NavBarItem extends StatelessWidget {
  final NavBarItemModel model;
  final HomeController _homeController = Get.find();
  final Color selectedColor = AppColors.primaryColor;
  final Color unSelectedColor = AppColors.secondaryColor;
  NavBarItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    var model = this.model;
    int index = model.index;
    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        // Get.to(navigationPath);
        // _homeController.goToTab(index);
        // locator<NavigationService>().navigateTo(navigationPath);

        debugPrint('index ${index}');
        _homeController.changePage(index);
        _homeController.closeDrawer();
      },
      child: Provider.value(
        value: model,
        child: ScreenTypeLayout.builder(
          desktop: (_) => navBarItemTabletDesktop(model: model),
          mobile: (_) => navBarItemMobile(model: model),
          tablet: (_) => navBarItemMobile(model: model),
        ),
      ),
    );
  }

  Widget navBarItemTabletDesktop({required NavBarItemModel model}) {
    return Obx(() => Container(
          height: 100,
          decoration: model.index == _homeController.currentIndex.value
              ? const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.white, width: 5)))
              : null,
          child: Center(
            child: Text(
              model.title.tr,
              style: TextStyle(
                  fontSize: 18,
                  color: model.index == _homeController.currentIndex.value
                      ? Colors.white
                      : Colors.white),
            ),
          ),
        ));
  }

  Widget navBarItemMobile({required NavBarItemModel model}) {
    return Obx(() => Padding(
          padding: const EdgeInsets.only(left: 30, top: 50),
          child: Row(
            children: <Widget>[
              Icon(
                model.iconData,
                color: model.index == _homeController.currentIndex.value
                    ? selectedColor
                    : unSelectedColor,
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                model.title.tr,
                style: TextStyle(
                    fontSize: 18,
                    color: model.index == _homeController.currentIndex.value
                        ? selectedColor
                        : unSelectedColor),
              )
            ],
          ),
        ));
  }
}
