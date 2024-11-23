import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  // Retrieve the theme preference when the app starts
  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  // Load the saved theme from SharedPreferences
  Future<void> _loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the value and explicitly cast it to a bool
    final theme = prefs.getBool('isDarkMode') ?? false;
    isDarkMode.value = theme;
    Get.changeTheme(isDarkMode.value ? darkTheme : lightTheme);
  }

  // Save the theme preference to SharedPreferences
  Future<void> _saveTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode.value);
  }

  // Toggle between light and dark theme
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _saveTheme(); // Save the updated theme to SharedPreferences
    Get.changeTheme(isDarkMode.value ? darkTheme : lightTheme);
  }

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlueAccent,
        secondaryHeaderColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30, // Default icon color
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: Colors.black, fontSize: 16),
          titleSmall: TextStyle(color: Colors.black, fontSize: 14),
          headlineLarge: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(
              color: Colors.white, fontSize: 14), // AppBar or smaller headers
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 16, 40, 74),
          foregroundColor: Colors.white,
        ),
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        secondaryHeaderColor: Colors.white,
        scaffoldBackgroundColor: const Color.fromARGB(255, 21, 21, 21),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30, // Default icon color
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: Colors.white, fontSize: 16),
          titleSmall: TextStyle(color: Colors.white, fontSize: 14),
          headlineLarge: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(
              color: Colors.white, fontSize: 14), // AppBar or smaller headers
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
      );
}
