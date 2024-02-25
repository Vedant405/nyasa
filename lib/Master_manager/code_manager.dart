import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class CodeController extends GetxController {
  static final CodeController _instance = CodeController._internal();

  factory CodeController() {
    return _instance;
  }

  CodeController._internal();

  RxList<Map<String, String>> codes = <Map<String, String>>[].obs;

  void addCode(String code, String making) {
    codes.add({'code': code, 'making': making});
  }

  void updateCode(int index, String code, String making) {
    codes[index] = {'code': code, 'making': making};
  }

  void deleteCode(int index) {
    codes.removeAt(index);
  }
}

class CodeManager extends StatelessWidget {
  final CodeController _codeController = CodeController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController makingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Code Manager"),
        backgroundColor: const Color.fromARGB(255, 51, 55, 59),
      ),
      backgroundColor: const Color.fromARGB(255, 51, 55, 59),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Obx(() {
          return _codeController.codes.isEmpty
              ? Center(
                  child: Text(
                    "No codes added yet",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : SingleChildScrollView(
                  child: Center(
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Code', style: TextStyle(color: Colors.white))),
                        DataColumn(label: Text('Making', style: TextStyle(color: Colors.white))),
                        DataColumn(label: Text('Actions', style: TextStyle(color: Colors.white))),
                      ],
                      rows: _codeController.codes.asMap().entries.map<DataRow>((entry) {
                        int index = entry.key;
                        Map<String, String> code = entry.value;
                        return DataRow(cells: [
                          DataCell(Text(code['code']!, style: TextStyle(color: Colors.white))),
                          DataCell(Text(code['making']!, style: TextStyle(color: Colors.white))),
                          DataCell(Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                color: Colors.blue,
                                onPressed: () {
                                  // Handle the update button
                                  showUpdateDialog(context, index);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  // Handle the delete button
                                  _codeController.deleteCode(index);
                                },
                              ),
                            ],
                          )),
                        ]);
                      }).toList(),
                    ),
                  ),
                );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show a dialog to get user input
          showAddDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue, // Customize the button color if needed
      ),
    );
  }

  // Show the dialog for adding a new code
  void showAddDialog(BuildContext context) {
  Get.defaultDialog(
    title: "Add Code",
    content: buildDialogBody(context, codeController, makingController),
    textCancel: "Cancel",
    textConfirm: "Add",
    confirm: ElevatedButton(
      onPressed: () {
        // Handle the add button in the dialog
        String code = codeController.text;
        String making = makingController.text;

        // Add the code and making to the CodeController
        _codeController.addCode(code, making);

        // Clear the text controllers
        codeController.clear();
        makingController.clear();

        // Close the dialog
        Get.back();
      },
      child: Text("Add"),
    ),
  );
}

// Show the dialog for updating an existing code
void showUpdateDialog(BuildContext context, int index) {
  TextEditingController updatedCodeController =
      TextEditingController(text: _codeController.codes[index]['code']);
  TextEditingController updatedMakingController =
      TextEditingController(text: _codeController.codes[index]['making']);

  Get.defaultDialog(
    title: "Update Code",
    content: buildDialogBody(
      context, 
      updatedCodeController,
      updatedMakingController,
    ),
    textCancel: "Cancel",
    textConfirm: "Update",
    confirm: ElevatedButton(
      onPressed: () {
        // Handle the update logic here
        _codeController.updateCode(
          index,
          updatedCodeController.text,
          updatedMakingController.text,
        );
        Navigator.pop(context);
      },
      child: Text("Update"),
    ),
  );
}

// Build the body of the dialog
Widget buildDialogBody(
  BuildContext context,
  TextEditingController codeController,
  TextEditingController makingController,
) {
  return Column(
    children: [
      TextField(
        onChanged: (value) {
          // Allow only capital letters
          codeController.text = value.toUpperCase();
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Z]')),
        ],
        controller: codeController,
        keyboardType: TextInputType.text, // Only capital letters
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.characters,
        decoration: InputDecoration(labelText: "Enter Code"),
      ),
      TextField(
        onChanged: (value) {
          // Allow only numbers
          makingController.text = value.replaceAll(RegExp(r'[^0-9]'), '');
        },
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        controller: makingController,
        keyboardType: TextInputType.number, // Only numbers
        decoration: InputDecoration(labelText: "Enter Making"),
      ),
    ],
  );
}}
