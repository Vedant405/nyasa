import 'package:flutter/material.dart';
import 'package:nyasa_acc2/Master_manager/master.dart';
import 'package:nyasa_acc2/pages/sell.dart';
import 'package:nyasa_acc2/utils/drawer.dart'; 
import 'package:nyasa_acc2/pages/purchase.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: const Color.fromARGB(255, 51, 55, 59),
        // Add a leading widget (drawer button)
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu), // You can use any icon you prefer
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the app-wide drawer
              },
            );
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 51, 55, 59),
      drawer: MyDrawer(), // Use the MyDrawer widget from the new file
      body: SingleChildScrollView( // Wrap the content in SingleChildScrollView
        child: Container(
          width: double.infinity, // Cover the entire width
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: (){
                    Get.to(Master());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    minimumSize: const Size(double.infinity, 100),
                  ),
                  child: Text("MASTER"),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16.0), // Add margin to the button
                child: ElevatedButton(
                  onPressed: () {
                     Get.to(const PurchasePage());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Change the button color as needed
                    minimumSize: const Size(double.infinity, 300), // Set a custom height
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.shopping_cart, // Replace with your desired icon
                        size: 48.0, // Set the icon size as needed
                      ),
                      SizedBox(height: 8.0), // Add spacing between icon and text
                      Text(
                        'Purchase',
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16.0), // Add margin to the button
                child: ElevatedButton(
                  onPressed: () {
                     Get.to(const SellPage());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Change the button color as needed
                    minimumSize: const Size(double.infinity, 300), // Set a custom height
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.attach_money_rounded, // Replace with your desired icon
                        size: 48.0, // Set the icon size as needed
                      ),
                      SizedBox(height: 8.0), // Add spacing between icon and text
                      Text(
                        'Sell',
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
