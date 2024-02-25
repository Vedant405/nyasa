import 'package:flutter/material.dart';
import 'package:nyasa_acc2/Master_manager/CurSrModifier.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SRController extends GetxController {
  RxDouble enteredValue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // Load the saved value when the controller is initialized
    loadEnteredValue();
  }

  void updateEnteredValue(double value) {
    enteredValue.value = value;
    // Save the updated value
    saveEnteredValue(value);
  }

  void loadEnteredValue() async {
    final prefs = await SharedPreferences.getInstance();
    enteredValue.value = prefs.getDouble('enteredValue') ?? 0.0;
  }

  void saveEnteredValue(double value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('enteredValue', value);
  }
}