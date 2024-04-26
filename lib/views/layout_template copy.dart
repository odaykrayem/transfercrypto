import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';
import '../controllers/home/HomeController.dart';
import '../utils/custom_scroll_behavior.dart';
import '../widgets/footer.dart';
import '../widgets/navbar.dart';
import '../widgets/navigation_drawer.dart';

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
                children: <Widget>[
                  NavBar(
                    navBarHeight: navBarHeight,
                  ),
                  SizedBox(
                    height: sizingInformation.deviceScreenType ==
                            DeviceScreenType.desktop
                        ? Get.size.height - navBarHeight
                        : Get.size.height,
                    child: Container(
                      color: AppColors.lightPurple,
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Navigator(
                          key: Get.nestedKey(1),
                          // initialRoute: '/no-connection',
                          onGenerateRoute: controller.onGenerateRoute,
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
}
