import 'package:transfercrypto/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'launcher_widget.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget(
      {super.key, this.size = 50, required this.image, required this.url});
  final String image;
  final String url;
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: Image.asset(
        image,
        height: size,
        width: size,
      ).onTap(() {
        launchUrlWidget(url);
      }),
    );
  }
}
