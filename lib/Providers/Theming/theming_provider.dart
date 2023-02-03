import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Providers/Theming/theming.dart';
import 'package:flutter_gen/gen_l10n/intl_localizations.dart';
import 'package:todo/UI/Tabs/SettingsTab/theming_bottom_sheet.dart';

class ThemingProvider extends ChangeNotifier {
  ThemeData appTheme = MyTheme.lightMode;

  void changeTheme(ThemeData newTheme) async {
    final prefs = await SharedPreferences.getInstance();

    if (newTheme == appTheme) {
      return;
    } else {
      appTheme = newTheme;
      prefs.setString('theme', newTheme == MyTheme.lightMode ? 'light' : 'dark');
      notifyListeners();
    }
  }

  String selectedTheme(BuildContext context) {
    if (appTheme == MyTheme.lightMode) {
      return AppLocalizations.of(context)!.light;
    } else {
      return AppLocalizations.of(context)!.dark;
    }
  }

  String unselectedTheme(BuildContext context) {
    if (appTheme == MyTheme.lightMode) {
      return AppLocalizations.of(context)!.dark;
    } else {
      return AppLocalizations.of(context)!.light;
    }
  }

  Widget changeView(bool selected, BuildContext context) {
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
              selectedTheme(context),
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
              unselectedTheme(context),
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

  showThemingBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return const ThemingBottomSheet();
        });
  }
}
