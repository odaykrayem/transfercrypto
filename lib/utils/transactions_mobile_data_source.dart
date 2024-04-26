import 'package:transfercrypto/extensions/int_extention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../constants/api_constants.dart';
import '../constants/app_colors.dart';
import '../controllers/transactions/TransactionsController.dart';
import '../data/status_values.dart';
import '../models/transaction_model.dart';
import 'dart:ui' as ui;


class TransactionsMobileDataSource extends DataGridSource {
  int i = 0;
  final double fontSize = 12;
  final Color fontColor = Colors.black;
  final double iconSize = 12;
  final double imageHeight = 30;
  final double imageWidth = 30;
  final String dateColumnName = 'datee';
  final String idColumnName = 'idd';
  final String fromColumnName = 'frommm';
  final String toColumnName = 'tooooo';
  final String statusColumnName = 'statusss';
  final String detailsColumnName = 'details';
  final VoidCallback onTap = () {
    debugPrint('clicked mobile');
  };

  TransactionsMobileDataSource({required List<TransactionModel> data}) {
    debugPrint('isEmpty : ${data.isEmpty}');
    _data = data
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<DateTime>(
                  columnName: dateColumnName, value: e.created_at),
              DataGridCell<int>(columnName: idColumnName, value: e.id),
              DataGridCell<TransactionModel>(
                  columnName: fromColumnName, value: e),
              DataGridCell<TransactionModel>(
                  columnName: toColumnName, value: e),
              DataGridCell<String>(
                  columnName: statusColumnName, value: statusValues[e.status]),
              DataGridCell<TransactionModel>(
                  columnName: detailsColumnName, value: e),
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
        padding: EdgeInsets.all((e.columnName == detailsColumnName ||
                e.columnName == fromColumnName ||
                e.columnName == toColumnName)
            ? 0.0
            : 8.0),
        child: e.columnName == statusColumnName
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      e.value.toString(),
                      softWrap: true,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: fontColor,
                      ),
                    ),
                  ),
                  1.width,
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
                    size: iconSize,
                  ),
                ],
              )
            : (e.columnName == fromColumnName || e.columnName == toColumnName)
                ? GestureDetector(
                    onTap: () {
                      Get.find<TransactionsController>().nextPage(e.value);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.transparent,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            e.columnName == fromColumnName
                                ? '${e.value.send_amount}'
                                : '${e.value.receive_amount}',
                           textDirection: ui.TextDirection.ltr,     
                            style: TextStyle(
                              fontSize: fontSize,
                              color: fontColor,
                            ),
                          ),
                          2.height,
                          ImageNetwork(
                            height: imageHeight,
                            width: imageWidth,
                            fitAndroidIos: BoxFit.contain,
                            fitWeb: BoxFitWeb.contain,
                            image: e.columnName == fromColumnName
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
                  )
                : e.columnName == detailsColumnName
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
                    : e.columnName == dateColumnName
                        // ? Text(convertDateTimeDisplay(e.value))
                        ? Text(
                            DateFormat('yyyy-MM-dd , hh:mm').format(e.value),
                            style: TextStyle(
                              fontSize: fontSize - 3,
                              color: fontColor,
                            ),
                          )
                        : Text(
                            e.value.toString(),
                            style: TextStyle(
                              fontSize: fontSize,
                              color: fontColor,
                            ),
                          ),
      );
    }).toList());
  }
}
