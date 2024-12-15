// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/contact_list_screen.dart';  

void main() {
  runApp(ContactManagerApp());
}

class ContactManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lista de Contatos',
      theme: ThemeData(
        primaryColor: Color(0xFF4267B2),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF4267B2),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4267B2),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: ContactListScreen(),
    );
  }
}