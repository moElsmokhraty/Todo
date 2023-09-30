import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String appLocale = "en";

  void changeLocale(String newLanguage) async {
    final prefs = await SharedPreferences.getInstance();
    if (appLocale == newLanguage) {
      return;
    } else {
      appLocale = newLanguage;
      prefs.setString('language', newLanguage);
      notifyListeners();
    }
  }

  String selectedLanguage() {
    if (appLocale == "en") {
      return 'English';
    } else {
      return 'العربية';
    }
  }

  String unselectedLanguage() {
    if (appLocale == "en") {
      return 'العربية';
    } else {
      return 'English';
    }
  }

  Widget changeView(bool selected) {
    if (selected) {
      return Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.all(12),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              selectedLanguage(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.check_outlined,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              unselectedLanguage(),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
  }
}
