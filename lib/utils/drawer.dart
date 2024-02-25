import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Drawer Item 1'),
            onTap: () {
              // Handle drawer item 1
            },
          ),
          ListTile(
            title: Text('Drawer Item 2'),
            onTap: () {
              // Handle drawer item 2
            },
          ),
          // Add more drawer items as needed
        ],
      ),
    );
  }
}
