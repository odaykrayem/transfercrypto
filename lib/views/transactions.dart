import 'transaction_details.dart';
import 'transactions_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transactions/TransactionsController.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransferState();
}

class _TransferState extends State<Transactions> {
  List<Widget> pages = [
    TransactionsTable(),
    TransactionDetails(),
  ];

  @override
  void dispose() {
    Get.find<TransactionsController>().pageViewController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Get.find<TransactionsController>().onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionsController>(builder: (controller) {
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
