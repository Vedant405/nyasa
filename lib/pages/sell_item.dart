import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyasa_acc2/utils/selected_value_controller.dart';
import 'sell_item_details.dart';

class SellItem extends StatefulWidget {
  @override
  _SellItemState createState() => _SellItemState();
}

class _SellItemState extends State<SellItem> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final SelectedValueController selectedValueController = Get.find();
  String selectedCategory = 'Rings'; // Default category

  final List<String> items = ['Rings', 'Tops', 'Necklace', 'Earrings'];

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  void initializeState() {
    // Initialize the state when the widget is created or revisited
    weightController.clear();
    codeController.clear();
    selectedCategory = 'Rings';
    selectedValueController.filteredItems.clear();
  }

  void filterItems(String weight, String code) {
    // Clear previous filtered items
    selectedValueController.filteredItems.clear();

    // Filter items based on weight, code, and category
    selectedValueController.filteredItems.addAll(
      selectedValueController.selectedValueList.where(
        (item) =>
            (weight.isEmpty || item['weight'] == weight) &&
            (code.isEmpty || item['code'] == code) &&
            (selectedCategory.isEmpty || item['value'] == selectedCategory),
      ),
    );
  }

  void clearFields() {
    // Clear text fields and filtered items
    setState(() {
      initializeState();
    });
  }

  void navigateToSellItemDetails(Map<String, dynamic> itemDetails) {
  Get.to(() => SellItemDetails(itemDetails: itemDetails));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sell Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                }
              },
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Weight',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Code',
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Access the entered values
                    String weight = weightController.text;
                    String code = codeController.text;

                    // Filter items based on entered weight, code, and category
                    filterItems(weight, code);
                  },
                  child: Text('Search'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Clear text fields and filtered items
                    clearFields();
                  },
                  child: Text('Clear'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
  child: Obx(
    () => ListView.builder(
      itemCount: selectedValueController.filteredItems.length,
      itemBuilder: (context, index) {
        // Access the item details
        var item = selectedValueController.filteredItems[index];

        // Display item details in a Card with a sell icon
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Category: ${item['value'] ?? ''}'),
                    Text('Code: ${item['code'] ?? ''}'),
                    Text('Weight: ${item['weight'] ?? ''}'),
                    Text('Pur SR: ${item['purSR'] ?? ''}'),
                    Text('Making: ${item['making'] ?? ''}'),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.sell), // Replace 'sell' with the desired icon
                  onPressed: () {
                    navigateToSellItemDetails(item);
                  },
                ),
              ),
            ],
          ),
        );
      },
    ),
  ),
),

          ],
        ),
      ),
    );
  }
}
