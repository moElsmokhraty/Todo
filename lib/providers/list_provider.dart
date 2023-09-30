import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/Models/todo.dart';
import 'package:todo/screens/tabs/list_tab/list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/screens/tabs/settings_tab/settings.dart';
import 'package:flutter_gen/gen_l10n/intl_localizations.dart';

import 'language_provider.dart';

class TodosProvider extends ChangeNotifier {
  DateTime calendarDate = DateTime.now();

  DateTime bottomSheetDate = DateTime.now();

  int currentIndex = 0;

  late String title;

  late String description;

  final key = GlobalKey<FormState>();

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<Widget> tabs = [const ListTab(), const SettingsTab()];

  CollectionReference<Todo> todosRef = Todo.withConverter();

  changeCalendarDate(DateTime date, DateTime events) {
    calendarDate = date;
    notifyListeners();
  }

  void addTodo(Todo todo, BuildContext context) {
    DocumentReference doc = todosRef.doc();
    todo.id = doc.id;
    doc.set(todo).timeout(
      const Duration(microseconds: 50),
      onTimeout: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.success_add,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.75,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(milliseconds: 750),
          ),
        );
      },
    );
  }

  Future<void> deleteTodo(Todo todo, BuildContext context) async {
    await todosRef.doc(todo.id).delete().timeout(
      const Duration(microseconds: 50),
      onTimeout: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.success_delete,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.75,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(milliseconds: 750),
          ),
        );
      },
    );
  }

  Future<void> markAsDone(Todo todo, BuildContext context) async {
    await todosRef.doc(todo.id).update({"isDone": true}).timeout(
      const Duration(microseconds: 50),
      onTimeout: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.success_done,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.75,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(milliseconds: 750),
          ),
        );
      },
    );
  }

  Future<void> markAsUnDone(Todo todo, BuildContext context) async {
    await todosRef.doc(todo.id).update({"isDone": false}).timeout(
      const Duration(microseconds: 50),
      onTimeout: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.success_undone,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.75,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(milliseconds: 750),
          ),
        );
      },
    );
  }

  Future<void> editTodo(Todo todo, BuildContext context) async {
    await FirebaseFirestore.instance
        .collection(Todo.collectionNAME)
        .doc(todo.id)
        .update({
      "title": todo.title,
      "description": todo.description,
      "date": todo.date
    }).timeout(
      const Duration(microseconds: 50),
      onTimeout: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.success_update,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.75,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(milliseconds: 500),
          ),
        );
      },
    );
  }

  Future<void> changeDate(Todo todo, BuildContext context) async {
    LanguageProvider languageProvider = Provider.of(context, listen: false);
    final taskDate = DateFormat('yyyy-MM-dd').parse(todo.date!);
    await showDatePicker(
      context: context,
      locale: Locale(languageProvider.appLocale),
      initialDate: taskDate,
      firstDate: taskDate.subtract(const Duration(days: 365)),
      lastDate: taskDate.add(const Duration(days: 365)),
    ).then(
      (date) {
        if (date == null) {
          return;
        } else {
          todo.date = '${date.year}-${date.month}-${date.day}';
          notifyListeners();
        }
      },
    );
  }

  Future<void> selectDate(DateTime dateTime, BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: dateTime.subtract(const Duration(days: 365)),
      lastDate: dateTime.add(const Duration(days: 365)),
    ).then(
      (date) {
        if (date == null) {
          return;
        } else {
          bottomSheetDate = date;
          notifyListeners();
        }
      },
    );
  }

  String? validateDescription(String value, BuildContext context) {
    if (value.isEmpty || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.validate_description;
    } else {
      return null;
    }
  }

  String? validateTitle(String value, BuildContext context) {
    if (value.isEmpty || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.validate_title;
    } else {
      return null;
    }
  }
}
