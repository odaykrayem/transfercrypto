import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transfercrypto/widgets/social_widget.dart';
import '../constants/app_colors.dart';
import '../constants/app_values.dart';
import '../controllers/home/HomeController.dart';
import '../data/nav_items_list.dart';
import 'google_play_widget.dart';
import 'launcher_widget.dart';

class Footer extends StatelessWidget {
  Footer({super.key});
  final Color backgroundColor = AppColors.secondaryColor;
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => footerMobile(),
      tablet: (_) => footerMobile(),
      desktop: (_) => footerTabletDesktop(),
    );
  }

  Widget footerTabletDesktop() {
    return Container(
      height: 310,
      padding: const EdgeInsets.only(right: 100, left: 100, top: 25, bottom: 5),
      color: backgroundColor,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              footerGroupItems(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  title: 'ourPages'.tr,
                  items: [
                    // 20.height,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SocialWidget(
                          image: 'assets/images/telegram.png',
                          url: AppValues.telegramURL,
                        ),
                        20.width,
                        SocialWidget(
                          image: 'assets/images/instagram.png',
                          url: AppValues.instgramURL,
                        ),
                        20.width,
                        SocialWidget(
                          image: 'assets/images/youtube.png',
                          url: AppValues.youtubeURL,
                        ),
                      ],
                    ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 5),
                    //   width: 250,
                    //   child: Text(
                    //      'downloadTheAppByClickingTheLinkBelow'.tr,

                    //     style: const TextStyle(color: Colors.white, fontSize: 18),
                    //     softWrap: true,
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    35.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialWidget(
                            image: 'assets/images/googleplay.png',
                            url: AppValues.appGooglePlayURL),
                        20.width,
                        SocialWidget(
                          image: 'assets/images/facebook.png',
                          url: AppValues.facebookURL,
                        ),
                        20.width,
                        SocialWidget(
                          image: 'assets/images/whatsapp.png',
                          url: AppValues.whatsappURL,
                        ),
                        // const GooglePlayWidget(
                        //   height: 50,
                        //   width: 100,
                        // ),
                      ],
                    ),
                  ]),
              footerGroupItems(title: AppValues.appName, items: [
                ...navigationItemsList.map((e) => footerItem(
                      content: e.title.tr,
                      onTap: () {
                        _homeController.changePage(e.index);
                      },
                    )),
              ]),
              GetBuilder<HomeController>(builder: (controller) {
                return footerGroupItems(title: 'contactUs'.tr, items: [
                  footerItem(
                      content: (controller.isAdminValuesLoaded &&
                              !controller.isErrorLoadingAdminValues)
                          ? '${_homeController.adminValuesList.firstWhere((element) => element.key == 'email').value}'
                          : '',
                      icon: Icons.email,
                      onTap: () {
                        launchUrlWidget((controller.isAdminValuesLoaded &&
                                !controller.isErrorLoadingAdminValues)
                            ? 'mailto:${_homeController.adminValuesList.firstWhere((element) => element.key == 'email').value}'
                            : '');
                      }),
                  footerItem(
                      content: (controller.isAdminValuesLoaded &&
                              !controller.isErrorLoadingAdminValues)
                          ? '${_homeController.adminValuesList.firstWhere((element) => element.key == 'phone').value}'
                          : '',
                      icon: Icons.phone,
                      onTap: () {
                        launchUrlWidget((controller.isAdminValuesLoaded &&
                                !controller.isErrorLoadingAdminValues)
                            ? 'tel:${_homeController.adminValuesList.firstWhere((element) => element.key == 'phone').value}'
                            : '');
                      }),
                  footerItem(
                    content: (controller.isAdminValuesLoaded &&
                            !controller.isErrorLoadingAdminValues)
                        ? '${_homeController.adminValuesList.firstWhere((element) => element.key == 'place').value}'
                        : '',
                    icon: Icons.location_on,
                  ),
                ]);
              }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              RichText(
                  text: const TextSpan(
                      text: '2023 © Copyright ',
                      style: TextStyle(
                        color: AppColors.textPrimaryColor,
                        fontSize: 12,
                      ),
                      children: [
                    TextSpan(
                        text: 'transfercrypto',
                        style: TextStyle(
                          color: AppColors.boldTextColor,
                          fontSize: 12,
                        )),
                    // WidgetSpan(
                    //     child: Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 5),
                    //   child: Center(
                    //     child: Image.asset(
                    //       'assets/images/icon64.png',
                    //       width: 18,
                    //       height: 18,
                    //       color: Colors.transparent,
                    //     ),
                    //   ),
                    // )),
                    // const TextSpan(
                    //     text: ' And Design By ',
                    //     style: TextStyle(
                    //       color: AppColors.textPrimaryColor,
                    //       fontSize: 14,
                    //     )),
                    // const TextSpan(
                    //     text: 'MrMind Team',
                    //     style: TextStyle(
                    //       color: AppColors.boldTextColor,
                    //       fontSize: 14,
                    //     )),
                  ]))
            ],
          ),
        ],
      ),
    );
  }

  Widget footerMobile() {
    return Container(
      height: 900,
      padding: const EdgeInsets.only(right: 30, left: 30, top: 25, bottom: 5),
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          footerGroupItems(
              title: 'ourPages'.tr,
              crossAxisAlignment: CrossAxisAlignment.center,
              items: [
                40.height,
                Wrap(
                  spacing: 35,
                  runSpacing: 40,
                  alignment: WrapAlignment.center,
                  children: [
                    SocialWidget(
                      image: 'assets/images/telegram.png',
                      url: AppValues.telegramURL,
                    ),
                    // 20.width,
                    SocialWidget(
                      image: 'assets/images/instagram.png',
                      url: AppValues.instgramURL,
                    ),
                    // 20.width,
                    SocialWidget(
                      image: 'assets/images/youtube.png',
                      url: AppValues.youtubeURL,
                    ),
                    SocialWidget(
                        image: 'assets/images/googleplay.png',
                        url: AppValues.appGooglePlayURL),
                    // 20.width,
                    SocialWidget(
                      image: 'assets/images/facebook.png',
                      url: AppValues.facebookURL,
                    ),
                    // 20.width,
                    SocialWidget(
                      image: 'assets/images/whatsapp.png',
                      url: AppValues.whatsappURL,
                    ),
                  ],
                ),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 5),
                //   width: 250,
                //   child: Text(
                //      'downloadTheAppByClickingTheLinkBelow'.tr,

                //     style: const TextStyle(color: Colors.white, fontSize: 18),
                //     softWrap: true,
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                30.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const GooglePlayWidget(
                    //   height: 50,
                    //   width: 100,
                    // ),
                  ],
                ),
              ]),
          footerGroupItems(
              crossAxisAlignment: CrossAxisAlignment.center,
              title: AppValues.appName,
              items: [
                ...navigationItemsList.map((e) => footerItem(
                      mainAxisAlignment: MainAxisAlignment.center,
                      content: e.title,
                      onTap: () {
                        _homeController.changePage(e.index);
                      },
                    )),
              ]),
          GetBuilder<HomeController>(builder: (controller) {
            return footerGroupItems(
                crossAxisAlignment: CrossAxisAlignment.center,
                title: 'contactUs'.tr,
                items: [
                  footerItem(
                      content: controller.isAdminValuesLoaded
                          ? '${_homeController.adminValuesList.firstWhere((element) => element.key == 'email').value}'
                          : '',
                      icon: Icons.email,
                      onTap: () {
                        launchUrlWidget(controller.isAdminValuesLoaded
                            ? 'mailto:${_homeController.adminValuesList.firstWhere((element) => element.key == 'email').value}'
                            : '');
                      },
                      mainAxisAlignment: MainAxisAlignment.center),
                  footerItem(
                      content: controller.isAdminValuesLoaded
                          ? '${_homeController.adminValuesList.firstWhere((element) => element.key == 'phone').value}'
                          : '',
                      icon: Icons.phone,
                      onTap: () {
                        launchUrlWidget(controller.isAdminValuesLoaded
                            ? 'tel:${_homeController.adminValuesList.firstWhere((element) => element.key == 'phone').value}'
                            : '');
                      },
                      mainAxisAlignment: MainAxisAlignment.center),
                  footerItem(
                      content: controller.isAdminValuesLoaded
                          ? '${_homeController.adminValuesList.firstWhere((element) => element.key == 'place').value}'
                          : '',
                      icon: Icons.location_on,
                      mainAxisAlignment: MainAxisAlignment.center),
                ]);
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              RichText(
                  text: const TextSpan(
                      text: '2023 © Copyright ',
                      style: TextStyle(
                        color: AppColors.textPrimaryColor,
                        fontSize: 12,
                      ),
                      children: [
                    TextSpan(
                        text: 'transfercrypto',
                        style: TextStyle(
                          color: AppColors.boldTextColor,
                          fontSize: 12,
                        )),
                  ]))
            ],
          ),
        ],
      ),
    );
  }

  Widget footerGroupItems(
      {required List<Widget> items,
      // bool isTitleImage = false,
      String? title,
      String? imagePath,
      CrossAxisAlignment? crossAxisAlignment}) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        imagePath != null
            ? SizedBox(
                width: 200,
                child: Image.asset(imagePath),
              )
            : title != null
                ? Container(
                    margin: const EdgeInsets.only(bottom: 15, top: 15),
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Outfit-Medium'),
                    ),
                  )
                : SizedBox.shrink(),
        ...items
      ],
    );
  }

  Widget footerItem({
    IconData? icon,
    required String content,
    double? iconSize,
    Color iconColor = Colors.white,
    VoidCallback? onTap,
    MainAxisAlignment? mainAxisAlignment,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          children: [
            icon != null
                ? Icon(
                    icon,
                    size: iconSize,
                    color: iconColor,
                  )
                : 0.width,
            5.width,
            Text(
              content,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
