import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../constants/app_colors.dart';
import '../controllers/transactions/TransactionsController.dart';
import '../utils/transactions_data_source.dart';
import '../utils/transactions_mobile_data_source.dart';
import '../widgets/custom_loader.dart';

class TransactionsTable extends StatefulWidget {
  const TransactionsTable({super.key});

  @override
  State<TransactionsTable> createState() => _TransactionsTableState();
}

class _TransactionsTableState extends State<TransactionsTable> {
  Future<void> _loadResources() async {
    try {
      final tController = Get.find<TransactionsController>();

      if (tController.initialized) {
        Get.find<TransactionsController>().getTransactionsList();
      } else {
        Get.lazyPut(() => TransactionsController(repo: Get.find()));
        Get.find<TransactionsController>().getTransactionsList();
      }
    } catch (e) {
      Get.lazyPut(() => TransactionsController(repo: Get.find()));
      Get.find<TransactionsController>().getTransactionsList();
    }
  }

  final DataGridController horizontalScrollController = DataGridController();
  @override
  void initState() {
    _loadResources();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => TransactionsMobile(),
      desktop: (_) => TransactionsDesktop(),
      tablet: (_) => TransactionsTablet(),
    );
  }

  Map<String, double> columnWidths = {
    'id': double.nan,
    'date': double.nan,
    'from': double.nan,
    'to': double.nan,
    'status': double.nan,
  };

  Widget TransactionsDesktop() {
    return Container(
      padding: const EdgeInsets.only(top: 35.0, bottom: 35.0),
      alignment: Alignment.center,
      child: GetBuilder<TransactionsController>(builder: (controller) {
        return controller.isLoaded
            ? controller.errorLoading
                ? const SizedBox.shrink()
                : SfDataGrid(
                    source: TransactionsDataSource(
                        data: controller.transactionsList),
                    columnWidthMode: ColumnWidthMode.fill,
                    defaultColumnWidth: 180,
                    rowHeight: 80,
                    allowSorting: true,
                    allowColumnsResizing: true,
                    showHorizontalScrollbar: true,
                    // horizontalScrollController: horizontalScrollController,
                    onColumnResizeUpdate: (details) {
                      setState(() {
                        columnWidths[details.column.columnName] = details.width;
                      });
                      return true;
                    },
                    highlightRowOnHover: true,

                    gridLinesVisibility: GridLinesVisibility.none,
                    columns: <GridColumn>[
                      GridColumn(
                        // columnWidthMode: ColumnWidthMode.fitByColumnName,
                        width: columnWidths['date']!,
                        columnName: 'date',
                        label: titleCellWidget(title: 'date'.tr),
                      ),
                      GridColumn(
                        // columnWidthMode: ColumnWidthMode.fitByColumnName,
                        width: columnWidths['id']!,
                        columnName: 'id',
                        label: titleCellWidget(title: 'id'.tr),
                      ),
                      GridColumn(
                          // columnWidthMode: ColumnWidthMode.fitByColumnName,
                          width: columnWidths['from']!,
                          columnName: 'from',
                          label: titleCellWidget(title: 'send'.tr),
                          allowSorting: false),
                      GridColumn(
                        // columnWidthMode: ColumnWidthMode.fitByColumnName,
                        width: columnWidths['to']!,
                        columnName: 'to',
                        label: titleCellWidget(title: 'receive'.tr),
                        allowSorting: false,
                      ),
                      GridColumn(
                        // columnWidthMode: ColumnWidthMode.fitByCellValue,
                        width: columnWidths['status']!,
                        // columnWidthMode: ColumnWidthMode.fitByCellValue,
                        columnName: 'status',
                        label: titleCellWidget(title: 'status'.tr),
                      ),
                      GridColumn(
                        columnWidthMode: ColumnWidthMode.fitByColumnName,
                        width: columnWidths['status']!,
                        allowSorting: false,
                        columnName: 'details',
                        label: titleCellWidget(title: 'details'.tr),
                      ),
                    ],
                  )
            : const CustomLoader();
      }),
    );
  }

  Widget TransactionsMobile() {
    return Container(
      padding: const EdgeInsets.only(top: 35.0, bottom: 35.0),
      alignment: Alignment.center,
      child: GetBuilder<TransactionsController>(builder: (controller) {
        return controller.isLoaded
            ? controller.errorLoading
                ? const SizedBox.shrink()
                : Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SfDataGrid(
                            source: TransactionsMobileDataSource(
                                data: controller.transactionsList),
                            columnWidthMode: ColumnWidthMode.fill,
                            // defaultColumnWidth: 100,
                            // allowSorting: true,
                            // allowColumnsResizing: true,
                            showHorizontalScrollbar: true,
                            // horizontalScrollController: horizontalScrollController,
                            onColumnResizeUpdate: (details) {
                              setState(() {
                                columnWidths[details.column.columnName] =
                                    details.width;
                              });
                              return true;
                            },
                            highlightRowOnHover: true,
                            gridLinesVisibility: GridLinesVisibility.none,
                            columns: <GridColumn>[
                              GridColumn(
                                // columnWidthMode:ColumnWidthMode.fitByColumnName,
                                width: columnWidths['date']!,
                                columnName: 'datee',
                                label: titleCellWidget(
                                    title: 'date'.tr, isMobile: true),
                              ),
                              GridColumn(
                                // columnWidthMode:ColumnWidthMode.fitByColumnName,
                                width: columnWidths['id']!,
                                columnName: 'idd',
                                label: titleCellWidget(
                                    title: 'id'.tr, isMobile: true),
                              ),
                              GridColumn(
                                // columnWidthMode:
                                //     ColumnWidthMode.fitByColumnName,
                                width: columnWidths['from']!,
                                columnName: 'frommm',
                                label: titleCellWidget(
                                    title: 'send'.tr, isMobile: true),
                              ),
                              GridColumn(
                                // columnWidthMode:
                                //     ColumnWidthMode.fitByColumnName,
                                width: columnWidths['to']!,
                                columnName: 'tooooo',
                                label: titleCellWidget(
                                    title: 'receive'.tr, isMobile: true),
                              ),
                              GridColumn(
                                // columnWidthMode:
                                //     ColumnWidthMode.fitByColumnName,
                                width: columnWidths['status']!,
                                columnName: 'statusss',
                                label: titleCellWidget(
                                    title: 'status'.tr, isMobile: true),
                              ),
                              GridColumn(
                                columnWidthMode:
                                    ColumnWidthMode.fitByColumnName,
                                width: columnWidths['status']!,
                                columnName: 'details',
                                label: titleCellWidget(
                                    title: 'details'.tr, isMobile: true),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
            : const CustomLoader();
      }),
    );
  }

  Widget TransactionsTablet() {
    return Container(
      padding: const EdgeInsets.only(top: 35.0, bottom: 35.0),
      alignment: Alignment.center,
      child: GetBuilder<TransactionsController>(builder: (controller) {
        return controller.isLoaded
            ? controller.errorLoading
                ? const SizedBox.shrink()
                : Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SfDataGrid(
                            source: TransactionsMobileDataSource(
                                data: controller.transactionsList),
                            columnWidthMode: ColumnWidthMode.fill,
                            // defaultColumnWidth: 100,
                            // allowSorting: true,
                            // allowColumnsResizing: true,
                            showHorizontalScrollbar: true,
                            // horizontalScrollController: horizontalScrollController,
                            onColumnResizeUpdate: (details) {
                              setState(() {
                                columnWidths[details.column.columnName] =
                                    details.width;
                              });
                              return true;
                            },
                            highlightRowOnHover: true,
                            gridLinesVisibility: GridLinesVisibility.none,
                            columns: <GridColumn>[
                              GridColumn(
                                // columnWidthMode:ColumnWidthMode.fitByColumnName,
                                width: columnWidths['date']!,
                                columnName: 'datee',
                                label: titleCellWidget(
                                    title: 'date'.tr, isMobile: true),
                              ),
                              GridColumn(
                                // columnWidthMode:ColumnWidthMode.fitByColumnName,
                                width: columnWidths['id']!,
                                columnName: 'idd',
                                label: titleCellWidget(
                                    title: 'id'.tr, isTablet: true),
                              ),
                              GridColumn(
                                // columnWidthMode:
                                //     ColumnWidthMode.fitByColumnName,
                                width: columnWidths['from']!,
                                columnName: 'frommm',
                                label: titleCellWidget(
                                    title: 'send'.tr, isTablet: true),
                              ),
                              GridColumn(
                                // columnWidthMode:
                                //     ColumnWidthMode.fitByColumnName,
                                width: columnWidths['to']!,
                                columnName: 'tooooo',
                                label: titleCellWidget(
                                    title: 'receive'.tr, isTablet: true),
                              ),
                              GridColumn(
                                // columnWidthMode:
                                //     ColumnWidthMode.fitByColumnName,
                                width: columnWidths['status']!,
                                columnName: 'statusss',
                                label: titleCellWidget(
                                    title: 'status'.tr, isTablet: true),
                              ),
                              GridColumn(
                                columnWidthMode:
                                    ColumnWidthMode.fitByColumnName,
                                width: columnWidths['status']!,
                                columnName: 'details',
                                label: titleCellWidget(
                                    title: 'details'.tr, isTablet: true),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
            : const CustomLoader();
      }),
    );
  }

  Widget titleCellWidget(
      {required String title, bool isMobile = false, bool isTablet = false}) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.textSecondaryColor.withOpacity(0.3)),
            color: AppColors.secondaryColor.withOpacity(0.3)),
        child: Text(
          title,
          softWrap: true,
          style: TextStyle(
              fontSize: isMobile
                  ? 12
                  : isTablet
                      ? 14
                      : 16,
              fontWeight: FontWeight.bold),
        ));
  }
}
