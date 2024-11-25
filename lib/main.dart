import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'res/getx_loclization/languages.dart';
import 'res/routes/routes.dart';
import 'res/colors/app_color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Locale? savedLocale = await _getSavedLocale();

  Get.put(ThemeController());

  runApp(MyApp(savedLocale: savedLocale));
}

Future<Locale?> _getSavedLocale() async {
  final prefs = await SharedPreferences.getInstance();
  String? languageCode = prefs.getString('languageCode');
  String? countryCode = prefs.getString('countryCode');

  if (languageCode != null && countryCode != null) {
    return Locale(languageCode, countryCode);
  }
  return null;
}

class MyApp extends StatelessWidget {
  final Locale? savedLocale;

  MyApp({Key? key, this.savedLocale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(() => GetMaterialApp(
          title: 'Cash Calculator',
          translations: Languages(),
          locale: savedLocale ?? const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          theme: themeController.lightTheme,
          darkTheme: themeController.darkTheme,
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
          getPages: AppRoutes.appRoutes(),
        ));
  }
}
