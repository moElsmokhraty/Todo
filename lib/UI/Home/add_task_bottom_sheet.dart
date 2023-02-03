import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/Models/todo.dart';
import 'package:todo/Providers/Theming/theming.dart';
import 'package:todo/Providers/Theming/theming_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {

  DateTime dateTime = DateTime.now();

  final key = GlobalKey<FormState>();

  late String title;

  late String description;

  CollectionReference<Todo> todosRef =  Todo.withConverter();

  @override
  Widget build(BuildContext context) {
    ThemingProvider themingProvider = Provider.of(context);
    return Form(
      key: key,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add New Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themingProvider.appTheme == MyTheme.lightMode
                      ? const Color(0xff141922)
                      : Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              style: TextStyle(
                  color: themingProvider.appTheme == MyTheme.lightMode
                      ? const Color(0xff141922)
                      : Colors.white),
              onChanged: (value) {
                title = value;
              },
              validator: (value) {
                return validateTitle(value!);
              },
              decoration: InputDecoration(
                  label: Text(
                'Task Title',
                style: TextStyle(
                    color: themingProvider.appTheme == MyTheme.lightMode
                        ? const Color(0xff141922)
                        : Colors.white),
              )),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              style: TextStyle(
                  color: themingProvider.appTheme == MyTheme.lightMode
                      ? const Color(0xff141922)
                      : Colors.white),
              onChanged: (value) {
                description = value;
              },
              validator: (value) {
                return validateDescription(value!);
              },
              decoration: InputDecoration(
                  label: Text('Task Details',
                      style: TextStyle(
                          color: themingProvider.appTheme == MyTheme.lightMode
                              ? const Color(0xff141922)
                              : Colors.white))),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                showMyDatePicker();
              },
              child: Text(
                'Select Date',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themingProvider.appTheme == MyTheme.lightMode
                        ? const Color(0xff141922)
                        : Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                child: Text(
                    style: TextStyle(
                        color: themingProvider.appTheme == MyTheme.lightMode
                            ? const Color(0xff141922)
                            : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                    DateFormat.yMd().format(dateTime))),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    addTodo();
                  } else {
                    return;
                  }
                },
                child: const Text('Add Task'))
          ],
        ),
      ),
    );
  }

  void showMyDatePicker() async {
    await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: dateTime.subtract(const Duration(days: 365)),
      lastDate: dateTime.add(const Duration(days: 365)),
    ).then((date) {
      if (date == null) {
        return;
      } else {
        setState(() {
          dateTime = date;
        });
      }
    });
  }

  void addTodo() {
    Todo todo =
    Todo(title: title, description: description, date: '${dateTime.year}-${dateTime.month}-${dateTime.day}', isDone: false);
    DocumentReference doc = todosRef.doc();
    todo.id = doc.id;
    doc.set(todo).timeout(const Duration(microseconds: 50), onTimeout: () {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: const Text('Task Added Successfully',
            textAlign: TextAlign.center),
            width: MediaQuery.of(context).size.width * 0.75,
            behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

}

String? validateDescription(String value) {
  if (value.isEmpty || value
      .trim()
      .isEmpty) {
    return 'Please enter your name';
  } else {
    return null;
  }
}

String? validateTitle(String value) {
  if (value.isEmpty || value
      .trim()
      .isEmpty) {
    return 'Please enter your name';
  } else {
    return null;
  }
}
