import 'package:transfercrypto/extensions/widget_extension.dart';
import 'package:flutter/material.dart';

import '../constants/app_values.dart';
import 'launcher_widget.dart';

class GooglePlayWidget extends StatelessWidget {
  const GooglePlayWidget(
      {super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/ic_play_store.png',
      height: height,
      width: width,
    ).onTap(() {
      launchUrlWidget(AppValues.appGooglePlayURL);
    });
  }
}
