// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Future<void> _loadResources() async {
    //when we call Getx titleAnimationController before GetMaterialApp they generally stay in the memory
    //but here we call them after
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    Timer(
      const Duration(seconds: 4),
      () {
        // Get.offNamed(Routes.getNoConnectionScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: SizedBox(height: 250.0, width: 250.0, child: Text('well')
                  // Image.asset('assets/images/splash_logo.png'),
                  ),
            )));
  }
}
