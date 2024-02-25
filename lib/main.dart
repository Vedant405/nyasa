import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nyasa_acc2/pages/login.dart';
import 'package:nyasa_acc2/pages/stock.dart';
import 'package:nyasa_acc2/utils/cur_sr.dart';
import 'package:nyasa_acc2/utils/selected_value_controller.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:nyasa_acc2/pages/new_item.dart';

void main() async {
  Get.put(SelectedValueController()); 
  Get.put(SRController());

 Get.put(SRController());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock Management',
      initialRoute: '/new_item',
      getPages: [
        GetPage(name: '/new_item', page: () => LoginPage()),
        GetPage(name: '/new_item', page: () => NewItem()),
        GetPage(name: '/details', page: () => Stock()),
      ],
    );
  }
}
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
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
    );
  }
}
