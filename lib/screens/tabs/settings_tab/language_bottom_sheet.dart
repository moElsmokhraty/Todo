import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/language_provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              languageProvider.changeLocale("en");
            },
            child:
                languageProvider.changeView(languageProvider.appLocale == "en"),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              languageProvider.changeLocale("ar");
            },
            child:
                languageProvider.changeView(languageProvider.appLocale == "ar"),
          )
        ],
      ),
    );
  }
}
