import 'package:flutter/material.dart';
import 'package:todo/Models/todo.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/list_provider.dart';
import 'package:todo/Providers/Theming/theming.dart';
import 'package:flutter_gen/gen_l10n/intl_localizations.dart';
import 'package:todo/Providers/Theming/theming_provider.dart';

class EditTask extends StatelessWidget {
  const EditTask({Key? key}) : super(key: key);

  static String routeName = 'Edit';

  @override
  Widget build(BuildContext context) {
    ThemingProvider themingProvider = Provider.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Todo todo = ModalRoute.of(context)!.settings.arguments as Todo;
    return Consumer<TodosProvider>(
      builder: (context, listProvider, child) {
        return Scaffold(
          backgroundColor: themingProvider.appTheme.scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.todo),
            elevation: 0,
            toolbarHeight: height * 0.15,
            titleSpacing: themingProvider.appTheme.appBarTheme.titleSpacing,
            systemOverlayStyle: themingProvider.appTheme.appBarTheme.systemOverlayStyle,
            backgroundColor: themingProvider.appTheme.appBarTheme.backgroundColor,
            titleTextStyle: themingProvider.appTheme.appBarTheme.titleTextStyle,
          ),
          body: Stack(
            children: [
              Container(
                height: height * 0.1,
                width: width,
                color: themingProvider.appTheme.appBarTheme.backgroundColor,
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  height: height * 0.7,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    color: themingProvider.appTheme == MyTheme.lightMode
                        ? Colors.white
                        : const Color(0xff141922),
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!.edit_task,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themingProvider.appTheme == MyTheme.lightMode
                              ? const Color(0xff060E1E)
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        initialValue: todo.title,
                        style: TextStyle(
                          color: themingProvider.appTheme == MyTheme.lightMode
                              ? const Color(0xff141922)
                              : Colors.white,
                        ),
                        onChanged: (value) {
                          todo.title = value;
                        },
                        decoration: InputDecoration(
                          label: Text(
                            AppLocalizations.of(context)!.task_title,
                            style: TextStyle(
                              color:
                                  themingProvider.appTheme == MyTheme.lightMode
                                      ? const Color(0xff141922)
                                      : Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        initialValue: todo.description,
                        style: TextStyle(
                          color: themingProvider.appTheme == MyTheme.lightMode
                              ? const Color(0xff141922)
                              : Colors.white,
                        ),
                        onChanged: (value) {
                          todo.description = value;
                        },
                        decoration: InputDecoration(
                          label: Text(
                          AppLocalizations.of(context)!.task_description,
                            style: TextStyle(
                              color:
                                  themingProvider.appTheme == MyTheme.lightMode
                                      ? const Color(0xff141922)
                                      : Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () async {
                          await listProvider.changeDate(todo, context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.select_date,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: themingProvider.appTheme == MyTheme.lightMode
                                ? const Color(0xff141922)
                                : Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          style: TextStyle(
                            color: themingProvider.appTheme == MyTheme.lightMode
                                ? const Color(0xff141922)
                                : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          '${todo.date}',
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            await listProvider.editTodo(todo, context);
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              AppLocalizations.of(context)!.save_changes,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
