import 'package:flutter/material.dart';
import 'package:nyasa_acc2/pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 51, 55, 59), // Set your desired background color here
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 200, // Adjust width as needed
                height: 200, // Adjust height as needed
              ),
            ),
            const SizedBox(
                height: 20), // Add spacing between the image and text
            const Text(
              "Log In",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              keyboardType: TextInputType.name,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter Username...",
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextField(
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter Password...",
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white), // Set underline color to white
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white), // Set underline color to white
                ),
              ),
            ),
            const SizedBox(
              height: 84,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Color.fromARGB(255, 51, 55, 59),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
