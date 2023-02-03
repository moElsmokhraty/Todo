import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Models/todo.dart';
import 'package:todo/Providers/Theming/theming.dart';
import 'package:flutter_gen/gen_l10n/intl_localizations.dart';
import 'package:todo/Providers/Theming/theming_provider.dart';

class EditTask extends StatefulWidget {
  const EditTask({Key? key}) : super(key: key);

  static String routeName = 'Edit';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late Todo todo;

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    ThemingProvider themingProvider = Provider.of(context);
    todo = ModalRoute.of(context)!.settings.arguments as Todo;
    return Scaffold(
      backgroundColor: themingProvider.appTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.todo),
        elevation: themingProvider.appTheme.appBarTheme.elevation,
        toolbarHeight: themingProvider.appTheme.appBarTheme.toolbarHeight,
        titleSpacing: themingProvider.appTheme.appBarTheme.titleSpacing,
        systemOverlayStyle:
            themingProvider.appTheme.appBarTheme.systemOverlayStyle,
        backgroundColor: themingProvider.appTheme.appBarTheme.backgroundColor,
        titleTextStyle: themingProvider.appTheme.appBarTheme.titleTextStyle,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            color: themingProvider.appTheme.appBarTheme.backgroundColor,
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: themingProvider.appTheme == MyTheme.lightMode
                    ? Colors.white
                    : const Color(0xff141922),
                borderRadius: const BorderRadius.all(Radius.circular(25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Edit Task',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themingProvider.appTheme == MyTheme.lightMode
                          ? const Color(0xff060E1E)
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: todo.title,
                    onChanged: (value) {
                      todo.title = value;
                    },
                    decoration: const InputDecoration(
                        label: Text(
                      'Task Title',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: todo.description,
                    onChanged: (value) {
                      todo.description = value;
                    },
                    decoration: const InputDecoration(
                        label: Text(
                      'Task Details',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      //showMyDatePicker(context);
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
                    height: 20,
                  ),
                  Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                          '${todo.date}')),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          editTodo(todo);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Task Edited Successfully',
                                  textAlign: TextAlign.center),
                              width: MediaQuery.of(context).size.width * 0.75,
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(milliseconds: 500),
                            ),
                          );
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ))),
                        child: const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            'Save Changes',
                            style: TextStyle(
                                //fontWeight: FontWeight.w200,
                                fontSize: 20),
                          ),
                        )),
                  ),
                  const Spacer()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showMyDatePicker(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.parse(todo.date!),
      firstDate: DateTime.parse(todo.date!).subtract(const Duration(days: 365)),
      lastDate: DateTime.parse(todo.date!).add(const Duration(days: 365)),
    ).then((date) {
      if (date == null) {
        return;
      } else {
        setState(() {
          todo.date = '${date.year}-${date.month}-${date.day}';
        });
      }
    });
  }

  void editTodo(Todo todo) {
    FirebaseFirestore.instance
        .collection(Todo.collectionNAME)
        .doc(todo.id)
        .update({
      "title": todo.title,
      "description": todo.description,
      "date": todo.date
    });
  }
}
