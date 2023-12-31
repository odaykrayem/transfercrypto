import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/home/HomeController.dart';
import '../utils/custom_scroll_behavior.dart';
import '../widgets/footer.dart';
import '../widgets/navbar.dart';
import '../widgets/navigation_drawer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LayoutTemplate extends GetView<HomeController> {
  LayoutTemplate({super.key});
  // final HomeController _homeController = Get.find();

  final ScrollController scrollController = ScrollController();
  final double navBarHeight = 100;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<HomeController>(() => HomeController(repo: Get.find()));
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: sizingInformation.deviceScreenType != DeviceScreenType.desktop
            ? NavDrawer(
                onCloseTapped: () {
                  controller.closeDrawer();
                },
              )
            : null,
        drawerEnableOpenDragGesture: false,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        key: controller.key,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return false;
          },
          // onNotification: (OverscrollIndicatorNotification? overscroll) {
          //   overscroll!.disallowIndicator();
          // },
          child: ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: RawScrollbar(
              controller: scrollController,
              thumbVisibility: true,
              trackVisibility: true,
              thumbColor: AppColors.secondaryColor.withOpacity(0.2),
              thickness: 7,
              interactive: true,
              child: ListView(
                scrollDirection: Axis.vertical,
                controller: scrollController,
                shrinkWrap: true,
                children: <Widget>[
                  NavBar(
                    navBarHeight: navBarHeight,
                  ),
                  kIsWeb
                      ? SizedBox(
                          height: sizingInformation.deviceScreenType ==
                                  DeviceScreenType.desktop
                              ? Get.size.height - navBarHeight
                              : (controller.currentIndex.value == 0 ||
                                      controller.currentIndex.value == 2)
                                  ? Get.size.height
                                  : Get.size.height + 400,
                          child: Container(
                            color: AppColors.lightPurple,
                            alignment: Alignment.topCenter,
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 1200,
                              ),
                              child: Navigator(
                                key: Get.nestedKey(1),
                                // initialRoute: '/no-connection',
                                onGenerateRoute: controller.onGenerateRoute,
                              ),
                            ),
                          ),
                        )
                      : Obx(() => SizedBox(
                            height: sizingInformation.deviceScreenType ==
                                    DeviceScreenType.desktop
                                ? Get.size.height - navBarHeight
                                : (controller.currentIndex.value == 0 ||
                                        controller.currentIndex.value == 2)
                                    ? Get.size.height
                                    : Get.size.height + 400,
                            child: Container(
                              color: AppColors.lightPurple,
                              alignment: Alignment.topCenter,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 1200,
                                ),
                                child: Navigator(
                                  key: Get.nestedKey(1),
                                  // initialRoute: '/no-connection',
                                  onGenerateRoute: controller.onGenerateRoute,
                                ),
                              ),
                            ),
                          )),
                  Footer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
