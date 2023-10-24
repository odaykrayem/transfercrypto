import 'package:flutter/material.dart';

import '../data/enums.dart';

class TextField {
  final TextEditingController controller;
  final TextFieldType textFieldType;
  final IconData? icon;
  final Color? iconColor;
  final String? hint;

  TextField(
      {required this.controller,
      required this.textFieldType,
      this.icon,
      this.iconColor,
      this.hint});
}
