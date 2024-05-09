import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:transfercrypto/models/review_model.dart';

import '../constants/app_colors.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.reviewModel});

  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
            20.width,
            Text(
              reviewModel.user_name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        5.height,
        Row(
          children: [
            10.width,
            RatingBarIndicator(
              rating: reviewModel.rating,
              itemSize: 15,
              unratedColor: Colors.grey[40],
              itemBuilder: (_, __) => Icon(
                Icons.star_rate_rounded,
                color: AppColors.primaryColor,
              ),
            ),
            20.width,
            Text(
              '${reviewModel.date}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        25.height,
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
          child: ReadMoreText(
            '${reviewModel.content}',
            trimLines: 1,
            trimMode: TrimMode.Length,
            trimExpandedText: 'showLess'.tr,
            trimCollapsedText: 'showMore'.tr,
            moreStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor),
            lessStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor),
          ),
        )
      ],
    );
  }
}
