import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../constants/app_colors.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({super.key, required this.title, required this.content});
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        var textAlignment = TextAlign.center;
        return SizedBox(
          width: 600,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                    fontSize: sizingInformation.deviceScreenType ==
                            DeviceScreenType.mobile
                        ? 40
                        : 80,
                    color: AppColors.textPrimaryColor),
                textAlign: textAlignment,
              ),
              30.height,
              SizedBox(
                width: 400,
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: sizingInformation.deviceScreenType ==
                            DeviceScreenType.mobile
                        ? 16
                        : 21,
                    height: 2,
                    color: AppColors.textSecondaryColor,
                  ),
                  textAlign: textAlignment,
                  maxLines: 2,
                  softWrap: true,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
