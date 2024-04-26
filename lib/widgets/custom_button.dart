import 'package:transfercrypto/extensions/hover_pointer_extinsion.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  CustomButton({super.key, required this.title, required this.onTap});

  final BorderRadius btnBorderRadius = BorderRadius.circular(15);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ScreenTypeLayout.builder(
        mobile: (_) => customButtonMobile(title),
        tablet: (_) => customButtonTabletDesktop(title),
      ),
    ).showCursorOnHover;
  }

  Widget customButtonMobile(String title) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        // gradient: ColorGradient.backgroundBtn,

        borderRadius: btnBorderRadius,
      ),
    );
  }

  Widget customButtonTabletDesktop(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        // gradient: ColorGradient.backgroundBtn,
        borderRadius: btnBorderRadius,
      ),
    );
  }
}
