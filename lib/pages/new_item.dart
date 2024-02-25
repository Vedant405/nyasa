import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nyasa_acc2/pages/stock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nyasa_acc2/utils/selected_value_controller.dart';


class NewItem extends StatelessWidget {
  NewItem({Key? key}) : super(key: key);

  final List<String> items = ['Rings', 'Tops', 'Necklace', 'Earrings'];
  final SelectedValueController selectedValueController =
      Get.put(SelectedValueController());
  final TextEditingController codeController = TextEditingController();
  final TextEditingController weightController =
      TextEditingController(); // Added controller for the weight text field
  final TextEditingController purSRController = TextEditingController(); // Add a controller for the "pur SR" category
  final TextEditingController makingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new item'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => DropdownButton<String>(
                      value: selectedValueController.selectedValue.value,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          selectedValueController.selectedValue.value =
                              newValue;
                        }
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    child: TextField(
                      controller: codeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Code',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Add spacing between the text fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    child: TextField(
                      controller: weightController,
                      keyboardType: TextInputType.numberWithOptions(
                          decimal:
                              true), // Set the keyboard type to accept float values
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Weight',
                      ),
                    ),
                  ),
                ],
              ),
               SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    child: TextField(
                      controller: purSRController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true), // Set the keyboard type to accept float values
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Pur SR',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    child: TextField(
                      controller: makingController, // Use the newly created controller
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Making',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ElevatedButton(
                    onPressed: () {
                      // Clear the text in each controller
                      codeController.clear();
                      weightController.clear();
                      purSRController.clear();
                      makingController.clear();
                    },
                    child: Text('Clear'),
                    style: ElevatedButton.styleFrom(
    primary: Colors.red,
                    ),
                  ),
                  SizedBox(width: 20), 
                  ElevatedButton(
                    onPressed: () {
                      String selectedValue =
                          selectedValueController.selectedValue.value;
                      String codeValue = codeController.text;
                      String weightValue = weightController.text;
                      String purSRValue = purSRController.text;
                      // Get the 'purSR' value from the controller
                      String makingValue = makingController.text;
                      selectedValueController.addSelectedValue(
                        selectedValue,
                        codeValue,
                        weightValue,
                        purSRValue,
                        makingValue,
                      ); // Pass the 'purSR' value
                      Get.toNamed('/details');
                    },
                    child: Text('Submit'),
                  ),
                  // Add space between buttons
                  
                ],
               ),
            ],
          ),
        ),
      ),
    );
  }
}

