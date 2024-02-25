import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nyasa_acc2/Master_manager/CurSrModifier.dart';
import 'package:nyasa_acc2/Master_manager/code_manager.dart';

class Master extends StatelessWidget {
  const Master({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Master Page"),
        backgroundColor: const Color.fromARGB(255, 51, 55, 59),
      ),
      backgroundColor: const Color.fromARGB(255, 51, 55, 59),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: (){
                    Get.to(CurSrPage());
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity,150),
                  ),
                  child: Text("Current Silver Rate"),
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: (){
                    Get.to(CodeManager());
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity,150),
                  ),
                  child: Text("Code"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}