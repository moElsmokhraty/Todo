import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/list_provider.dart';

import '../../../Models/todo.dart';
import '../../../Providers/Theming/theming.dart';
import '../../../Providers/Theming/theming_provider.dart';
import '../../../Providers/language_provider.dart';
import '../../Home/edit_task_screen.dart';

class UnDoneTodoItem extends StatelessWidget {
  const UnDoneTodoItem({required this.todo, Key? key}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    ThemingProvider themingProvider = Provider.of(context);
    LanguageProvider languageProvider = Provider.of(context);
    TodosProvider listProvider = Provider.of(context);
    return Slidable(
      key: UniqueKey(),
      closeOnScroll: false,
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () async {
            await listProvider.deleteTodo(todo, context);
          },
        ),
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: languageProvider.appLocale == 'en'
                    ? const BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )
                    : const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    languageProvider.appLocale == 'en' ? 'Delete' : 'حذف',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, EditTask.routeName, arguments: todo);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            color: themingProvider.appTheme == MyTheme.lightMode
                ? Colors.white
                : const Color(0xff141922),
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                width: 3,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.all(6),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      todo.title!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: themingProvider.appTheme == MyTheme.lightMode
                            ? const Color(0xff060E1E)
                            : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      todo.description!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: themingProvider.appTheme == MyTheme.lightMode
                            ? const Color(0xff060E1E)
                            : Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  await listProvider.markAsDone(todo, context);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.blueAccent,
                  ),
                  child: const Icon(
                    Icons.check_outlined,
                    size: 40,
                    color: Colors.white,
                    opticalSize: 0.2,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
