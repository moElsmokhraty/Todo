import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/Theming/theming.dart';
import 'package:todo/Providers/Theming/theming_provider.dart';

class ThemingBottomSheet extends StatelessWidget {
  const ThemingBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemingProvider themingProvider = Provider.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                themingProvider.changeTheme(MyTheme.lightMode);
              },
              child: themingProvider.changeView(
                  themingProvider.appTheme == MyTheme.lightMode, context)),
          const SizedBox(height: 10),
          InkWell(
              onTap: () {
                themingProvider.changeTheme(MyTheme.darkMode);
              },
              child: themingProvider.changeView(
                  themingProvider.appTheme == MyTheme.darkMode, context)),
        ],
      ),
    );
  }
}
