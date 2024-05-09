import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:transfercrypto/constants/app_colors.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:transfercrypto/views/add_review.dart';
import 'package:transfercrypto/widgets/custom_loader.dart';
import 'package:transfercrypto/widgets/review_card.dart';

import '../controllers/home/HomeController.dart';
import '../controllers/reviews/ReviewsController.dart';
import '../data/repository/home_repo.dart';
import '../routes/routes.dart';
import '../widgets/custom_button.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  // final _pageViewController = PageController(
  //   initialPage: 0,
  // );
  List<Widget> pages = [];

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadResources() async {
    try {
      final tController = Get.find<ReviewsController>();

      if (tController.initialized) {
        Get.find<ReviewsController>().getReviewsList();
      } else {
        Get.lazyPut(() => ReviewsController(repo: Get.find()));
        Get.find<ReviewsController>().getReviewsList();
      }
    } catch (e) {
      Get.lazyPut(() => ReviewsController(repo: Get.find()));
      Get.find<ReviewsController>().getReviewsList();
    }
  }

  @override
  void initState() {
    // Get.find<ReviewsController>().onInit();
    // _loadResources();
    debugPrint('init transfer');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<HomeController>(() => HomeController(repo: Get.find()));
    Get.lazyPut<HomeRepo>(() => HomeRepo(apiClient: Get.find()));
    final HomeController _homeController = Get.find<HomeController>();

    return GetBuilder<ReviewsController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                debugPrint('previous ::: ${Get.previousRoute}');

                if (Get.previousRoute == Routes.main) {
                  Get.back();
                } else {
                  Get.offNamed(Routes.main);
                }
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: ResponsiveBuilder(builder: (context, sizingInfo) {
          return Container(
            padding: EdgeInsets.only(
                bottom:
                    (sizingInfo.deviceScreenType == DeviceScreenType.desktop)
                        ? 10.0
                        : 0.0),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'ratingAndReviewsPageAreVerifiedAndFromPeopleWhoUseOurServices'
                              .tr,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: (sizingInfo.deviceScreenType ==
                                    DeviceScreenType.desktop)
                                ? 21
                                : 16,
                          ),
                        ),
                      ),
                      (sizingInfo.deviceScreenType == DeviceScreenType.desktop)
                          ? CustomButton(
                              title: 'addReview'.tr,
                              onTap: () {
                                _homeController.isLoggedIn()
                                    ? _homeController.openDialog(AddReview())
                                    : Get.toNamed(Routes.login);
                                // : _homeController.openDialog(const LoginPage());
                              },
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  20.height,
                  (sizingInfo.deviceScreenType != DeviceScreenType.desktop)
                      ? CustomButton(
                          title: 'addReview'.tr,
                          onTap: () {
                            _homeController.isLoggedIn()
                                ? _homeController.openDialog(AddReview())
                                : Get.toNamed(Routes.login);
                            // : _homeController.openDialog(const LoginPage());
                          },
                        )
                      : SizedBox.shrink(),
                  (sizingInfo.deviceScreenType != DeviceScreenType.desktop)
                      ? 20.height
                      : 0.height,
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${controller.allRating.toStringAsFixed(1)}',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                      // Expanded(
                      //     flex: 2,
                      //     child: VerticalDivider(
                      //       width: 3,
                      //       thickness: 3,
                      //       color: Colors.red,
                      //     )),
                      Expanded(
                        flex: 7,
                        child: Column(
                          children: [
                            MyRatingBar(
                              text: '5',
                              value: controller.ratingFive,
                              showStars: (sizingInfo.deviceScreenType ==
                                  DeviceScreenType.desktop),
                            ),
                            MyRatingBar(
                              text: '4',
                              value: controller.ratingFour,
                              showStars: sizingInfo.deviceScreenType ==
                                  DeviceScreenType.desktop,
                            ),
                            MyRatingBar(
                              text: '3',
                              value: controller.ratingThree,
                              showStars: sizingInfo.deviceScreenType ==
                                  DeviceScreenType.desktop,
                            ),
                            MyRatingBar(
                              text: '2',
                              value: controller.ratingTwo,
                              showStars: sizingInfo.deviceScreenType ==
                                  DeviceScreenType.desktop,
                            ),
                            MyRatingBar(
                              text: '1',
                              value: controller.ratingOne,
                              showStars: sizingInfo.deviceScreenType ==
                                  DeviceScreenType.desktop,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  RatingBarIndicator(
                    rating: controller.allRating,
                    itemSize: 20,
                    unratedColor: Colors.grey[40],
                    itemBuilder: (_, __) => Icon(
                      Icons.star_rate_rounded,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.person,
                        size: 15,
                      ),
                      Text(
                        '${controller.ratingCount}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  30.height,
                  controller.isLoaded
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: controller.reviewsList.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: ((context, index) {
                                return Column(
                                  children: [
                                    ReviewCard(
                                      reviewModel:
                                          controller.reviewsList[index],
                                    ),
                                    20.height,
                                  ],
                                );
                              })),
                        )
                      : CustomLoader()
                ],
              ),
            ),
          );
        }),
      );
    });
  }
}

class MyRatingBar extends StatelessWidget {
  final String text;
  final double value;
  final bool showStars;
  const MyRatingBar({
    super.key,
    required this.text,
    required this.value,
    required this.showStars,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showStars
            ? Expanded(
                flex: 2,
                child: RatingBarIndicator(
                  textDirection: TextDirection.ltr,
                  rating: double.parse(text),
                  itemSize: 20,
                  unratedColor: Colors.grey[50],
                  itemBuilder: (_, __) => Icon(
                    Icons.star_rate_rounded,
                    color: AppColors.primaryColor,
                  ),
                ))
            : SizedBox.shrink(),
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 10,
          child: SizedBox(
            width: 200,
            child: LinearProgressIndicator(
              value: value / 100,
              minHeight: 11,
              backgroundColor: Colors.grey[40],
              valueColor: AlwaysStoppedAnimation(AppColors.secondaryColor),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        )
      ],
    );
  }
}
