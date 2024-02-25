import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyasa_acc2/utils/cur_sr.dart';

class CurSrPage extends StatefulWidget {
  const CurSrPage({Key? key}) : super(key: key);

  @override
  _CurSrPageState createState() => _CurSrPageState();
}

class _CurSrPageState extends State<CurSrPage> {
  TextEditingController currentRateController = TextEditingController();
  SRController controller = Get.find<SRController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Current Silver Rate"),
        backgroundColor: const Color.fromARGB(255, 51, 55, 59),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  'Current Silver Rate: ${controller.enteredValue.value}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 20),
            Container(
              width: 300,
              child: TextField(
                controller: currentRateController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Update Silver Rate',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform the update action when the button is pressed
                // Update the value in the SRController
                controller.updateEnteredValue(double.tryParse(currentRateController.text) ?? 0);
              },
              child: Text("Update"),
            )
          ],
        ),
      ),
    );
  }
}
