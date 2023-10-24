import 'package:flutter/material.dart';

extension WidgetExtension on Widget? {
  /// add tap to parent widget
  Widget onTap(
    Function? function, {
    BorderRadius? borderRadius,
    Color? splashColor,
    Color? hoverColor,
    Color? highlightColor,
  }) {
    return InkWell(
      onTap: function as void Function()?,
      borderRadius: borderRadius,
      splashColor: splashColor ?? Colors.transparent,
      hoverColor: hoverColor ?? Colors.transparent,
      highlightColor: highlightColor,
      child: this,
    );
  }
}
