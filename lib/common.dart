import 'package:flutter/material.dart';

import 'constants/app_colors.dart';

InputDecoration commonInputDecoration(
    {String? hintText,
    IconData? suffixIcon,
    Function()? suffixOnTap,
    Widget? prefixIcon}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    filled: true,
    hintText: hintText ?? '',
    hintStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.textSecondaryColor,
      fontWeight: FontWeight.normal,
    ),
    fillColor: Colors.grey.withOpacity(0.15),
    counterText: '',
    suffixIcon: suffixIcon != null
        ? GestureDetector(
            onTap: suffixOnTap,
            child: Icon(suffixIcon, color: Colors.grey, size: 22))
        : null,
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(style: BorderStyle.none),
        borderRadius: BorderRadius.circular(8.0)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(8.0)),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8.0)),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8.0)),
  );
}
