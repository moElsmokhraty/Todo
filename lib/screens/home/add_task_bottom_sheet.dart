import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:todo/Models/todo.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/list_provider.dart';
import 'package:todo/Providers/Theming/theming.dart';
import 'package:todo/Providers/Theming/theming_provider.dart';
import 'package:flutter_gen/gen_l10n/intl_localizations.dart';

class AddTaskBottomSheet extends StatelessWidget {
  const AddTaskBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemingProvider themingProvider = Provider.of(context);
    TodosProvider listProvider = Provider.of(context);
    return Form(
      key: listProvider.key,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.add_new_task,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themingProvider.appTheme == MyTheme.lightMode
                    ? const Color(0xff141922)
                    : Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              style: TextStyle(
                color: themingProvider.appTheme == MyTheme.lightMode
                    ? const Color(0xff141922)
                    : Colors.white,
              ),
              onChanged: (value) {
                listProvider.title = value;
              },
              validator: (value) {
                return listProvider.validateTitle(value!, context);
              },
              decoration: InputDecoration(
                label: Text(
                  AppLocalizations.of(context)!.task_title,
                  style: TextStyle(
                    color: themingProvider.appTheme == MyTheme.lightMode
                        ? const Color(0xff141922)
                        : Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              style: TextStyle(
                color: themingProvider.appTheme == MyTheme.lightMode
                    ? const Color(0xff141922)
                    : Colors.white,
              ),
              onChanged: (value) {
                listProvider.description = value;
              },
              validator: (value) {
                return listProvider.validateDescription(value!, context);
              },
              decoration: InputDecoration(
                label: Text(
                  AppLocalizations.of(context)!.task_description,
                  style: TextStyle(
                    color: themingProvider.appTheme == MyTheme.lightMode
                        ? const Color(0xff141922)
                        : Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () async {
                await listProvider.selectDate(DateTime.now(), context);
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
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                DateFormat.yMd().format(listProvider.bottomSheetDate),
              ),
            ),
            const Expanded(child: SizedBox(height: 15)),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (listProvider.key.currentState!.validate()) {
                    listProvider.addTodo(
                      Todo(
                        title: listProvider.title,
                        description: listProvider.description,
                        date:
                            '${listProvider.bottomSheetDate.year}-${listProvider.bottomSheetDate.month}-${listProvider.bottomSheetDate.day}',
                        isDone: false,
                      ),
                      context,
                    );
                  } else {
                    return;
                  }
                },
                child: Text(AppLocalizations.of(context)!.add_task),
              ),
            )
          ],
        ),
      ),
    );
  }
}
