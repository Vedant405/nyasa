import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyasa_acc2/pages/sell_item.dart';
import 'package:nyasa_acc2/pages/sold_items.dart';
import 'package:nyasa_acc2/utils/selected_value_controller.dart';

class SellPage extends StatelessWidget {
  const SellPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell'),
        backgroundColor: const Color.fromARGB(255, 51, 55, 59),
      ),
      backgroundColor: const Color.fromARGB(255, 51, 55, 59),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(SellItem());
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_shopping_cart, // Use the shopping cart icon for adding items
                  size: 24.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Sell an item',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(SoldItemsPage());
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.assignment_turned_in, // Use the assignment turned in icon for sold items
                  size: 24.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Sold items',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
