import 'package:flutter/material.dart';
import 'package:transfercrypto/extensions/hover_pointer_extinsion.dart';

class CustomGesture extends StatelessWidget {
  CustomGesture({super.key, required this.child, this.onTap});

  final Widget child;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: child,
    ).showCursorOnHover;
  }
}
