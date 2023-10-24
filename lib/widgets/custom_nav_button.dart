import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../constants/app_colors.dart';
import 'hover_widget.dart';

class CustomNavButton extends StatelessWidget {
  final String title;
  final VoidCallback onButtonPressed;
  CustomNavButton(
      {super.key, required this.onButtonPressed, required this.title});

  final BorderRadius btnBorderRadius = BorderRadius.circular(15);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      // onHover: (value) => ,
      child: ScreenTypeLayout.builder(
        mobile: (_) => customNavButtonMobile(title),
        tablet: (_) => customNavButtonTabletDesktop(title),
      ),
    );
  }

  Widget customNavButtonMobile(String title) {
    return GestureDetector(
      onTap: onButtonPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              // width: ,
              alignment: Alignment.center,
              // margin: const EdgeInsets.symmetric(
              //   horizontal: 30,
              // ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                // gradient: ColorGradient.backgroundBtn,

                borderRadius: btnBorderRadius,
              ),

              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customNavButtonTabletDesktop(String title) {
    return GestureDetector(
      onTap: onButtonPressed,
      child: HoverWidget(builder: (context, isHoviring) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isHoviring ? AppColors.secondaryColor : Colors.white,
            // gradient: ColorGradient.backgroundBtn,
            borderRadius: btnBorderRadius,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isHoviring ? Colors.white : AppColors.primaryColor,
            ),
          ),
        );
      }),
    );
  }
}
