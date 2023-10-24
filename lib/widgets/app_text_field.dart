// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData? icon;
  final bool isObscure;
  final bool isEmail;
  final bool isNumber;
  final bool isDone;
  final double hintFontSize;
  final double fontSize;
  final Color iconColor;

  const AppTextField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
    this.isEmail = false,
    this.isNumber = false,
    this.isDone = false,
    this.hintFontSize = 18,
    this.iconColor = Colors.black38,
    this.fontSize = 22,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(
      //   left: 20,
      //   right: 20,
      // ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(1, 1),
              color: Colors.grey.withOpacity(0.2)),
        ],
      ),
      child: TextField(
        obscureText: isPasswordVisible ? !widget.isObscure : widget.isObscure,
        textInputAction:
            widget.isDone ? TextInputAction.done : TextInputAction.next, //By me
        controller: widget.textController,
        keyboardType: widget.isEmail
            ? TextInputType.emailAddress
            : widget.isNumber
                ? TextInputType.number
                : TextInputType.text,
        style: const TextStyle(fontSize: 22),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontSize: widget.hintFontSize == 0 ? 22 : widget.hintFontSize),
          prefixIcon: widget.icon != null
              ? Icon(
                  widget.icon,
                  color: widget.iconColor,
                )
              : null,
          suffixIcon: widget.isObscure
              ? GestureDetector(
                  child: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onTap: () {
                    isPasswordVisible = !isPasswordVisible;

                    setState(() {});
                  },
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
        ),
      ),
    );
  }
}
