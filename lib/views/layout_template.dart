import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transfercrypto/data/repository/home_repo.dart';
import '../constants/app_colors.dart';
import '../controllers/home/HomeController.dart';
import '../utils/custom_scroll_behavior.dart';
import '../widgets/footer.dart';
import '../widgets/navbar.dart';
import '../widgets/navigation_drawer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LayoutTemplate extends GetView<HomeController> {
  LayoutTemplate({super.key});

  final ScrollController scrollController = ScrollController();
  final double navBarHeight = 100;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<HomeController>(() => HomeController(repo: Get.find()));
    Get.lazyPut<HomeRepo>(() => HomeRepo(apiClient: Get.find()));
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
                  // kIsWeb
                  //     ? SizedBox(
                  //         height: sizingInformation.deviceScreenType ==
                  //                 DeviceScreenType.desktop
                  //             ? Get.size.height - navBarHeight
                  //             : (controller.currentIndex.value == 0 ||
                  //                     controller.currentIndex.value == 2)
                  //                 ? Get.size.height
                  //                 : Get.size.height + 1100,
                  //         child: Container(
                  //           color: AppColors.lightPurple,
                  //           alignment: Alignment.topCenter,
                  //           child: ConstrainedBox(
                  //             constraints: const BoxConstraints(
                  //               maxWidth: 1200,
                  //             ),
                  //             child: Navigator(
                  //               key: Get.nestedKey(1),
                  //               // initialRoute: '/no-connection',
                  //               onGenerateRoute: controller.onGenerateRoute,
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     :
                  Obx(
                    () => SizedBox(
                      height: calculateHeihgt(sizingInformation),
                      child: Container(
                        color: AppColors.lightPurple,
                        // color: generateColor(sizingInformation),
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
                    ),
                  ),
                  Footer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double calculateHeihgt(SizingInformation sizingInformation) {
    debugPrint('screen Height: ${Get.size.height}');
    debugPrint('screen Index: ${controller.currentIndex.value}');
    if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
      if (controller.currentIndex.value == 0 ||
          controller.currentIndex.value == 2) {
        return Get.size.height - navBarHeight + 10;
      } else {
        debugPrint(
            'screen Part Height: ${Get.size.height - navBarHeight + 100}');
        if (Get.size.height < 700) {
          return Get.size.height + 60;
        } else {
          return Get.size.height - navBarHeight + 25;
        }
      }
    } else if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
      return Get.size.height + 100;
    } else {
      if (controller.currentIndex.value == 0 ||
          controller.currentIndex.value == 2) {
        return Get.size.height;
      } else {
        return Get.size.height + 500;
      }
    }
  }

  Color generateColor(SizingInformation sizingInformation) {
    if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
      if (controller.currentIndex.value == 0 ||
          controller.currentIndex.value == 2) {
        return Colors.amber;
      } else {
        debugPrint(
            'screen Part Height: ${Get.size.height - navBarHeight + 100}');
        if (Get.size.height < 610) {
          return Colors.red;
        } else {
          return Colors.green;
        }
      }
    } else if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
      return Colors.purple;
    } else {
      if (controller.currentIndex.value == 0 ||
          controller.currentIndex.value == 2) {
        return Colors.lightBlueAccent;
      } else {
        return Colors.pink;
      }
    }
  }
}
