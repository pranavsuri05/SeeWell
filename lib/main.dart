import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Ensure this import is correct

void main() {
  runApp(SeeWellApp());
}

class SeeWellApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeeWell',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // Ensure LoginScreen is correctly imported
    );
  }
}