import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyasa_acc2/utils/cur_sr.dart';
import 'package:nyasa_acc2/pages/sold_items.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellItemDetails extends StatefulWidget {
  final Map<String, dynamic> itemDetails;

  SellItemDetails({required this.itemDetails});

  @override
  _SellItemDetailsState createState() => _SellItemDetailsState();
}

class _SellItemDetailsState extends State<SellItemDetails> {
  // Define a TextEditingController for the making value
  TextEditingController makingController = TextEditingController();

  // Create an instance of the CurSRController
  SRController controller = Get.find<SRController>();

  // Variable to store the final rate
  RxDouble finalRate = RxDouble(0.0);

  // Variable to store the discount value
  RxDouble discount = RxDouble(0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Item Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              children: [
                // Existing DataTable code
                DataTable(
  columnSpacing: 100.0,
  columns: const [
    DataColumn(
      label: Text(
        'Field',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Value',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  ],
  rows: [
    buildDataRow('Category', widget.itemDetails['value'] ?? ''),
    buildDataRow('Code', widget.itemDetails['code'] ?? ''),
    buildDataRow('Weight', widget.itemDetails['weight'] ?? ''),
    buildDataRow('Pur SR', widget.itemDetails['purSR'] ?? ''),
    // Add more rows as needed
  ],
),

                const SizedBox(height: 20.0), // Add spacing between DataTable and TextField
                // TextField for making value
                TextField(
                  controller: makingController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Enter Making',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10.0), // Add spacing between TextField and button
                // "Go" button
                ElevatedButton(
                  onPressed: () {
                    // Handle the action when the "Go" button is pressed
                    // Calculate the final rate based on the formula
                    double weight = double.tryParse(widget.itemDetails['weight'] ?? '') ?? 0.0;
                    double making = double.tryParse(makingController.text) ?? 0.0;
                    double curSRDividedBy1000 = controller.enteredValue.value/1000;

                    finalRate.value = (weight * making) + (weight * curSRDividedBy1000);
                    print(curSRDividedBy1000);
                  },
                  child: const Text('Go'),
                ),
                const SizedBox(height: 20.0), // Add spacing between "Go" button and final rate
                // Final Rate Text
                const Text(
                  'Final Rate:',
                  style: TextStyle(fontSize: 20.0),
                ),
                // Final Rate Value (Bold)
                Obx(
                  () => Text(
                    finalRate.value.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20.0), // Add spacing between "Final Rate" and "Sell" button
                // "Sell" button
                ElevatedButton(
                  onPressed: () {
                    // Show the discount dialog
                    _showDiscountDialog();
                  },
                  child: const Text('SELL'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataRow buildDataRow(String field, String? value) {
  return DataRow(
    cells: [
      DataCell(Text(field)),
      DataCell(Text(value ?? '')), // Use empty string if value is null
    ],
  );
}


  // Function to show the discount dialog
  Future<void> _showDiscountDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Discount'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Do you want to give any discount?'),
              const SizedBox(height: 10.0),
              TextField(
                onChanged: (value) {
                  discount.value = double.tryParse(value) ?? 0.0;
                },
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Enter Discount',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle the action when the "Apply Discount" button is pressed
                // You can use the discount value as needed
                Navigator.of(context).pop();
                _showConfirmationDialog();
              },
              child: const Text('Apply Discount'),
            ),
          ],
        );
      },
    );
  }

  // Function to show the confirmation dialog after applying the discount
  Future<void> _showConfirmationDialog() async {
    double making = double.tryParse(makingController.text) ?? 0.0;
    double weight = double.tryParse(widget.itemDetails['weight'] ?? '') ?? 0.0;
    double curSRDividedBy1000 = controller.enteredValue.value/1000; // use sr instead of curSR

    double originalPrice = (weight * making) + (weight * curSRDividedBy1000);
    double discountedFinalRate = originalPrice - discount.value;

    Get.defaultDialog(
      title: 'Confirmation',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Discount Applied: ${discount.value.toStringAsFixed(2)}'),
          const SizedBox(height: 10.0),
          Text('Discounted Final Rate: ${discountedFinalRate.toStringAsFixed(2)}'),
          Text('Original Price: ${originalPrice.toStringAsFixed(2)}'), // Display original price
          Text('Making: $making'), // Display making value
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('OK'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back(); // Close the current dialog
            _saveDataAndNavigateToSoldItemsPage(making, originalPrice, discountedFinalRate);
          },
          child: const Text('View Sold Items'),
        ),
      ],
    );
  }

  // Function to save data to SharedPreferences and navigate to SoldItemsPage
  Future<void> _saveDataAndNavigateToSoldItemsPage(double making, double originalPrice, double discountedFinalRate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('category', widget.itemDetails['value'] ?? '');
    prefs.setString('code', widget.itemDetails['code'] ?? '');
    prefs.setString('weight', widget.itemDetails['weight'] ?? '');
    // Save other relevant data as needed

    Get.to(
      () => SoldItemsPage(
        soldItemDetails: {
          'category': widget.itemDetails['value'] ?? '',
          'code': widget.itemDetails['code'] ?? '',
          'weight': widget.itemDetails['weight'] ?? '',
          'making': making, // Include making value in soldItemDetails
          'discountApplied': discount.value,
          'discountedFinalRate': discountedFinalRate,
          'originalPrice': originalPrice,
        },
      ),
    );
  }
}
