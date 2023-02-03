import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/intl_localizations.dart';
import 'package:todo/Providers/Theming/theming.dart';
import 'package:todo/Providers/Theming/theming_provider.dart';
import 'package:todo/Providers/language_provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of(context);
    ThemingProvider themingProvider = Provider.of(context);
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: TextStyle(
              color: themingProvider.appTheme == MyTheme.lightMode ? const Color(0xff141922)
                  : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),),
          const SizedBox(height: 10),
          InkWell(
            onTap: (){
              languageProvider.showLanguageBottomSheet(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Theme.of(context).primaryColor)
              ),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(languageProvider.selectedLanguage()
                    , style: TextStyle(
                    color: themingProvider.appTheme.primaryColor,
                  ),),
                  const Spacer(),
                  Icon(Icons.arrow_downward, color: Theme.of(context).primaryColor,)
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(AppLocalizations.of(context)!.mode,
            style: TextStyle(
              color: themingProvider.appTheme == MyTheme.lightMode ? const Color(0xff141922)
                  : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),),
          const SizedBox(height: 10),
          InkWell(
            onTap: (){
              themingProvider.showThemingBottomSheet(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Theme.of(context).primaryColor)
              ),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Text(themingProvider.selectedTheme(context), style: TextStyle(
                    color: Theme.of(context).primaryColor
                  ),),
                  const Spacer(),
                  Icon(Icons.arrow_downward, color: Theme.of(context).primaryColor,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}
