import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyasa_acc2/utils/selected_value_controller.dart';

class Stock extends StatelessWidget {
  final SelectedValueController selectedValueController = Get.find();

  List<DataRow> generateRows(BuildContext context) {
    // Generate rows for the DataTable
    List<DataRow> rows = [];
    for (int index = 0;
        index < selectedValueController.selectedValueList.length;
        index++) {
      String value = selectedValueController.selectedValueList[index]['value']!;
      String code = selectedValueController.selectedValueList[index]['code']!;
      String weight =
          selectedValueController.selectedValueList[index]['weight']!;
      String purSR = selectedValueController.selectedValueList[index]['purSR']!;
      String making = selectedValueController.selectedValueList[index]['making']!;
      rows.add(DataRow(cells: [
        DataCell(Align(
          alignment: Alignment.center,
          child: Text(value),
        )),
        DataCell(Align(
          alignment: Alignment.center,
          child: Text(code),
        )),
        DataCell(Align(
          alignment: Alignment.center,
          child: Text(weight),
        )),
        DataCell(Align(
          alignment: Alignment.center,
          child: Text(purSR),
        )),
        DataCell(Align(
          alignment: Alignment.center,
          child: Text(making),
        )),
        DataCell(
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmationDialog(context, index);
            },
          ),
        ),
      ]));
    }
    return rows;
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                selectedValueController.removeSelectedValue(index);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Obx(
              () => DataTable(
                dataRowHeight: 50,
                columnSpacing: 20,
                dividerThickness: 1.0,
                showBottomBorder: true,
                columns: [
                  DataColumn(
                    label: Text('Category'),
                  ),
                  DataColumn(
                    label: Text('Code'),
                  ),
                  DataColumn(
                    label: Text('Weight'),
                  ),
                  DataColumn(
                    label: Text('Pur SR'),
                  ),
                  DataColumn(
                    label: Text('Making'),
                  ),
                  DataColumn(
                    label: Text('Actions'),
                  ),
                ],
                rows: generateRows(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
