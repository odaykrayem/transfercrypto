import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NavBarItemModel {
  final String title;
  final String navigationPath;
  final IconData? iconData;
  final int index;
  bool? isReviews;

  NavBarItemModel({
    required this.title,
    required this.navigationPath,
    required this.iconData,
    required this.index,
    this.isReviews = false,
  });
}
