import 'package:flutter/material.dart';
import 'package:transfercrypto/widgets/custom_gesture.dart';

import '../constants/app_colors.dart';

class CustomButton2 extends StatelessWidget {
  CustomButton2({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.iconColor,
    this.iconBeforeText = false,
  });
  final Color? backgroundColor;
  final Color? textColor;
  final String text;
  final VoidCallback onTap;
  final IconData? icon;
  final Color? iconColor;
  final bool iconBeforeText;
  @override
  Widget build(BuildContext context) {
    return CustomGesture(
      onTap: onTap,
      child: Container(
        // width: 150,
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor ?? AppColors.primaryColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconBeforeText
                  ? icon != null
                      ? Icon(
                          icon,
                          color: iconColor ?? Colors.white,
                        )
                      : SizedBox.shrink()
                  : SizedBox.shrink(),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: textColor ?? Colors.white,
                ),
              ),
              !iconBeforeText
                  ? icon != null
                      ? Icon(
                          icon,
                          color: iconColor ?? Colors.white,
                        )
                      : SizedBox.shrink()
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
