import 'package:transfercrypto/controllers/transactions/TransactionsController.dart';
import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../constants/api_constants.dart';
import '../constants/app_colors.dart';
import '../data/status_values.dart';
import '../models/transaction_model.dart';
import 'dart:ui' as ui;


class TransactionsDataSource extends DataGridSource {
  int i = 0;
  final VoidCallback onTap = () {
    debugPrint('clicked desktop');
  };

  TransactionsDataSource({required List<TransactionModel> data}) {
    debugPrint('isEmpty : ${data.isEmpty}');
    _data = data
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<DateTime>(columnName: 'date', value: e.created_at),
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<TransactionModel>(columnName: 'from', value: e),
              DataGridCell<TransactionModel>(columnName: 'to', value: e),
              DataGridCell<String>(
                  columnName: 'status', value: statusValues[e.status]),
              DataGridCell<TransactionModel>(columnName: 'details', value: e),
            ]))
        .toList();
  }

  List<DataGridRow> _data = [];

  @override
  List<DataGridRow> get rows => _data;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    i++;
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: i % 2 == 0
                ? AppColors.secondaryColor.withOpacity(0.3)
                : AppColors.primaryColor.withOpacity(0.5),
            border: Border(
                bottom: BorderSide(
                    color: AppColors.textSecondaryColor.withOpacity(0.2)))),
        padding: EdgeInsets.all((e.columnName == 'details' ||
                e.columnName == 'from' ||
                e.columnName == 'to')
            ? 0.0
            : 8.0),
        child: e.columnName == 'status'
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(e.value.toString()),
                  10.width,
                  Icon(
                    e.value.toString() == statusValues[0]
                        ? Icons.access_time
                        : e.value.toString() == statusValues[1]
                            ? Icons.done_all
                            : Icons.do_not_disturb_alt_outlined,
                    color: e.value.toString() == statusValues[0]
                        ? Colors.blueAccent
                        : e.value.toString() == statusValues[1]
                            ? Colors.greenAccent
                            : Colors.red[400],
                    size: 25,
                  ),
                ],
              )
            : (e.columnName == 'from' || e.columnName == 'to')
                ? GestureDetector(
                    onTap: () {
                      Get.find<TransactionsController>().nextPage(e.value);
                      // Get.toNamed(
                      //     Routes.getTransactionDetails(e.value.toJson()));
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(e.columnName == 'from'
                                ? '${e.value.send_amount}'
                                : '${e.value.receive_amount}',
                                textDirection: ui.TextDirection.ltr,
                                ),
                            10.width,
                            ImageNetwork(
                              height: 70,
                              width: 70,
                              fitAndroidIos: BoxFit.contain,
                              fitWeb: BoxFitWeb.contain,
                              image: e.columnName == 'from'
                                  ? (ApiConstants.imageUrl +
                                          e.value.from_wallet_icon)
                                      .replaceAll('\\', '/')
                                  : (ApiConstants.imageUrl +
                                          e.value.to_wallet_icon)
                                      .replaceAll('\\', '/'),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : e.columnName == 'details'
                    ? GestureDetector(
                        onTap: () {
                          Get.find<TransactionsController>().nextPage(e.value);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Center(
                            child: Icon(
                              Icons.info_outline,
                              color: AppColors.primaryColor,
                              size: 27,
                            ),
                          ),
                        ),
                      )
                    : e.columnName == 'date'
                        // ? Text(convertDateTimeDisplay(e.value))
                        ? Text(
                            DateFormat('yyyy-MM-dd , hh:mm a').format(e.value))
                        : Text(e.value.toString()),
      );
    }).toList());
  }
}
