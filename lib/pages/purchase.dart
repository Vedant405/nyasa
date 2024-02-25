import 'package:flutter/material.dart';
import 'package:nyasa_acc2/pages/new_item.dart';
import 'package:nyasa_acc2/pages/stock.dart';
import 'package:get/get.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase'),
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
              Get.to(NewItem());
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 20.0), // Set the button height
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 24.0, // Set the icon size
                ),
                SizedBox(width: 8.0), // Add spacing between icon and text
                Text(
                  'Add new item',
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
              Get.to(Stock());
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 20.0), // Set the button height
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.list,
                  size: 24.0, // Set the icon size
                ),
                SizedBox(width: 8.0), // Add spacing between icon and text 
                Text(
                  'Stock',
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
