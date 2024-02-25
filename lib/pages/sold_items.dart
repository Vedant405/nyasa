import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SoldItemsPage extends StatelessWidget {
  final Map<String, dynamic>? soldItemDetails;

  SoldItemsPage({this.soldItemDetails});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sold Items Table'),
        ),
        body: ProductTable(soldItemDetails: soldItemDetails ?? {}),
      ),
    );
  }
}

class ProductTable extends StatelessWidget {
  final Map<String, dynamic>? soldItemDetails;

  ProductTable({required this.soldItemDetails});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Category')),
          DataColumn(label: Text('Code')),
          DataColumn(label: Text('Weight')),
          DataColumn(label: Text('Making')),  // Add Making column
          DataColumn(label: Text('Original Price')),
          DataColumn(label: Text('Discount Applied')),
          DataColumn(label: Text('Discounted Final Rate')),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text(soldItemDetails?['category'] ?? '')),
            DataCell(Text(soldItemDetails?['code'] ?? '')),
            DataCell(Text(soldItemDetails?['weight']?.toString() ?? '')), // Convert to String
            DataCell(Text(soldItemDetails?['making']?.toString() ?? '')), // Convert to String
            DataCell(Text(soldItemDetails?['originalPrice']?.toStringAsFixed(2) ?? '')),
            DataCell(Text(soldItemDetails?['discountApplied']?.toStringAsFixed(2) ?? '')),
            DataCell(Text(soldItemDetails?['discountedFinalRate']?.toStringAsFixed(2) ?? '')),
          ]),
        ],
      ),
    );
  }
}