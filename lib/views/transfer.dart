import 'package:transfercrypto/controllers/transfer/TransferController.dart';
import 'transfer_first_step.dart';
import 'transfer_second_step.dart';
import 'transfer_third_step.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transfer extends StatefulWidget {
  const Transfer({super.key});

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  // final _pageViewController = PageController(
  //   initialPage: 0,
  // );
  List<Widget> pages = [
    const TransferFirstStep(),
    const TransferSecondStep(),
    const TransferThirdStep(),
  ];

  @override
  void dispose() {
    Get.find<TransferController>().pageViewController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Get.find<TransferController>().onInit();
    debugPrint('init transfer');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransferController>(builder: (controller) {
      return Container(
        // padding: const EdgeInsets.only(top: 35.0, bottom: 35.0),
        alignment: Alignment.center,
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          body: PageView(
              controller: controller.pageViewController,
              children: pages,
              physics: NeverScrollableScrollPhysics()),
        ),
      );
    });
  }
}
