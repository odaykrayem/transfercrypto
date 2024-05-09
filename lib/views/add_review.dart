import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:transfercrypto/controllers/reviews/ReviewsController.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import '../constants/app_colors.dart';
import '../utils/show_custom_snackbar.dart';
import '../widgets/custom_gesture.dart';

class AddReview extends StatefulWidget {
  AddReview({super.key});

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  TextEditingController textEditingController = TextEditingController();

  void onValueChange() {
    setState(() {
      textEditingController.text;
    });
  }

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(onValueChange);
  }

  void _submit(ReviewsController controller) {
    controller.addReview(textEditingController.text ?? '').then((response) {
      debugPrint('${response.isSuccess}');
      if (response.isSuccess) {
        showCustomSnackBar('reviewAdded'.tr, isError: false, title: '');
        // Get.back(closeOverlays: true);
      } else {
        showCustomSnackBar(response.message, isError: true, title: 'error'.tr);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewsController>(builder: (controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 35,
              // right: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 1,
                    offset: const Offset(1, 1),
                    color: Colors.grey.withOpacity(0.2)),
              ],
            ),
            child: TextField(
              obscureText: false,
              textInputAction: TextInputAction.done, //By me
              controller: textEditingController,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(fontSize: 22),
              inputFormatters: [
                LengthLimitingTextInputFormatter(200),
              ],
              maxLength: 200,
              maxLines: 8,
              decoration: InputDecoration(
                counterText: "200/${200 - textEditingController.text.length}",
                hintText: 'addReview'.tr,
                hintStyle: TextStyle(fontSize: 22),
                // prefixIcon: Icon(
                //   Icons.reviews_rounded,
                //   color: Colors.deepPurple[400],
                // ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
              ),
            ),
          ),
          10.height,
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(23),
            ),
            child: RatingBar(
                minRating: 1,
                maxRating: 5,
                itemSize: 45,
                initialRating: 1,
                allowHalfRating: false,
                ratingWidget: RatingWidget(
                    full: Icon(
                      Icons.star_rounded,
                      color: AppColors.secondaryColor,
                    ),
                    half: Icon(Icons.star_half_rounded),
                    empty: Icon(
                      Icons.star_border_rounded,
                      color: Colors.grey[500],
                    )),
                onRatingUpdate: (rating) {
                  controller.setUserRating(rating);
                  debugPrint('${rating}');
                }),
          ),
          20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomGesture(
                onTap: () {
                  Navigator.of(Get.overlayContext!).pop();
                },
                child: Container(
                  width: 150,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      'cancel'.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              CustomGesture(
                onTap: () {
                  Navigator.of(Get.overlayContext!).pop();

                  _submit(controller);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      'ok'.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      );
    });
  }
}
