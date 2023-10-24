import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import "package:universal_html/html.dart" as html;

extension HoverExtension on Widget {
  static final appContainer =
      html.window.document.getElementById('app-container');
  Widget get showCursorOnHover {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return sizingInformation.deviceScreenType != DeviceScreenType.mobile
          ? MouseRegion(
              opaque: false,
              cursor: SystemMouseCursors.click,
              onHover: (event) => appContainer!.style.cursor = 'pointer',
              onExit: (event) => appContainer!.style.cursor = 'default',
              child: this,
            )
          : GestureDetector(
              child: this,
            );
    });
  }
}
