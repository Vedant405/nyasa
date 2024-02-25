import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyasa_acc2/pages/sell_item.dart';
import 'package:nyasa_acc2/pages/stock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/new_item.dart';

class SelectedValueController extends GetxController {
  var selectedValue = 'Rings'.obs;
  var selectedValueList = <Map<String, String>>[].obs;
  var filteredItems = <Map<String, String>>[].obs;
  late SharedPreferences prefs; // SharedPreferences instance

  @override
  void onInit() {
    super.onInit();
    initPrefs(); // Initialize SharedPreferences
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? storedValues = prefs.getStringList('selectedValues');
    if (storedValues != null) {
      selectedValueList.value = storedValues.map((item) {
        Map<String, dynamic> decodedItem = jsonDecode(item);
        return {
          'value': decodedItem['value'] as String? ?? '',
          'code': decodedItem['code'] as String? ?? '',
          'weight': decodedItem['weight'] as String? ?? '',
          'purSR': decodedItem['purSR'] as String? ?? '',
          'making': decodedItem['making'] as String? ?? '',
        };
      }).toList();
    }
  }

  void addSelectedValue(String value, String code, String weight, String purSR, String making) {
    selectedValueList.add({
      'value': value,
      'code': code,
      'weight': weight,
      'purSR': purSR,
      'making': making,
    });
    List<String> stringList =
        selectedValueList.map((item) => jsonEncode(item)).toList();
    prefs.setStringList('selectedValues', stringList);
    update(); // Notify GetX that the list has been updated
  }

  void removeSelectedValue(int index) {
    selectedValueList.removeAt(index);
    List<String> stringList =
        selectedValueList.map((item) => jsonEncode(item)).toList();
    prefs.setStringList('selectedValues', stringList);
    update(); // Notify GetX that the list has been updated
  }

  void filterItems(String weight, String code) {
    filteredItems.value = selectedValueList.where((item) {
      return item['weight'] == weight && item['code'] == code;
    }).toList();
  }
}

void main() {
  Get.put(SelectedValueController());
  runApp(GetMaterialApp(
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => NewItem()),
      GetPage(name: '/details', page: () => Stock()),
      GetPage(name: '/details', page: () => SellItem()),
    ],
  ));
}
