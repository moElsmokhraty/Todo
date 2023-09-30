import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/Theming/theming.dart';
import 'package:todo/Providers/Theming/theming_provider.dart';
import 'package:todo/Providers/list_provider.dart';
import 'package:todo/screens/home/add_task_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/intl_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String routeName = 'Home';

  @override
  Widget build(BuildContext context) {
    ThemingProvider themingProvider = Provider.of(context);
    final toolbarHeight = MediaQuery.of(context).size.height * 0.15;
    return Consumer<TodosProvider>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            if (provider.currentIndex == 1) {
              provider.changeIndex(0);
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text('Do you want to exit Todo?'),
                    actions: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
                        child: const Text("NO"),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => SystemNavigator.pop(),
                        child: const Text("YES"),
                      ),
                      const SizedBox(width: 2),
                    ],
                  );
                },
              );
            }
            return Navigator.canPop(context);
          },
          child: Scaffold(
            backgroundColor: themingProvider.appTheme.scaffoldBackgroundColor,
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.todo),
              elevation: themingProvider.appTheme.appBarTheme.elevation,
              systemOverlayStyle:
                  themingProvider.appTheme.appBarTheme.systemOverlayStyle,
              toolbarHeight: toolbarHeight,
              titleSpacing: themingProvider.appTheme.appBarTheme.titleSpacing,
              backgroundColor:
                  themingProvider.appTheme.appBarTheme.backgroundColor,
              titleTextStyle:
                  themingProvider.appTheme.appBarTheme.titleTextStyle,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: themingProvider.appTheme == MyTheme.lightMode
                      ? Colors.white
                      : const Color(0xff141922),
                  context: context,
                  builder: (context) {
                    return const AddTaskBottomSheet();
                  },
                );
              },
              backgroundColor: themingProvider.appTheme.primaryColor,
              shape: const StadiumBorder(
                side: BorderSide(color: Colors.white, width: 4),
              ),
              child: const Icon(Icons.add_outlined, size: 30),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              clipBehavior: Clip.hardEdge,
              notchMargin: 8,
              child: BottomNavigationBar(
                selectedItemColor: Colors.blueAccent,
                unselectedItemColor: Colors.grey,
                backgroundColor: themingProvider.appTheme == MyTheme.lightMode
                    ? Colors.white
                    : const Color(0xff141922),
                currentIndex: provider.currentIndex,
                onTap: (index) {
                  provider.changeIndex(index);
                },
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list), label: 'List',),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Settings'),
                ],
              ),
            ),
            body: provider.tabs[provider.currentIndex],
          ),
        );
      },
    );
  }
}
