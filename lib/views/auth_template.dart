import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AuthTemplate extends StatelessWidget {
  AuthTemplate({super.key, required this.child, this.isProfile = false});

  final String image = 'assets/images/login_img.jpeg';
  final String image2 = 'assets/images/logo1080.png';
  final Widget child;
  final bool isProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: ScreenTypeLayout.builder(
        mobile: (_) => homeMobile(),
        desktop: (_) => homeDesktop(),
        tablet: (_) => homeMobile(),
      ),
    );
  }

  Widget homeMobile() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: child,
    );
  }

  Widget homeDesktop() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: child,
          ),
        ),
        Expanded(
          child: SizedBox(
            child: Stack(
              children: [
                Positioned(
                    top: 10,
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      isProfile ? image2 : image,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
