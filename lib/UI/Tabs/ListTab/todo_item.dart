import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Models/todo.dart';
import 'package:todo/Providers/Theming/theming.dart';
import 'package:todo/Providers/Theming/theming_provider.dart';
import 'package:todo/Providers/language_provider.dart';
import 'package:todo/UI/Home/edit_task_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoItem extends StatelessWidget {
  Todo? todo;

  TodoItem({this.todo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemingProvider themingProvider = Provider.of(context);
    LanguageProvider languageProvider = Provider.of(context);
    if(todo!.isDone == false) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, EditTask.routeName, arguments: todo);
        },
        child: Slidable(
          key: UniqueKey(),
          closeOnScroll: false,
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {
              deleteTodo(todo!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Task Deleted Successfully',
                      textAlign: TextAlign.center),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.75,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(milliseconds: 500),
                ),
              );
            }),
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.13,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: languageProvider.appLocale == 'en'
                        ? const BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        topRight: Radius.circular(25))
                        : const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        topLeft: Radius.circular(25)),
                  ),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.13,
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
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: Column(
                    children: [
                      Text(
                        todo!.title!,
                        style: TextStyle(
                            color: themingProvider.appTheme == MyTheme.lightMode
                                ? const Color(0xff060E1E)
                                : Colors.white),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Text(
                        todo!.description!,
                        style: TextStyle(
                            color: themingProvider.appTheme == MyTheme.lightMode
                                ? const Color(0xff060E1E)
                                : Colors.white),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: (){
                    //listProvider.changeDone(todo!.isDone!);
                    markAsDone(todo!, context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.height * 0.12,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.blueAccent,
                    ),
                    child: const Icon(
                      Icons.check_outlined,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, EditTask.routeName, arguments: todo);
        },
        child: Slidable(
          key: UniqueKey(),
          closeOnScroll: false,
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () {
              deleteTodo(todo!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Task Deleted Successfully',
                      textAlign: TextAlign.center),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.75,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(milliseconds: 500),
                ),
              );
            }),
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.13,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: languageProvider.appLocale == 'en'
                        ? const BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        topRight: Radius.circular(25))
                        : const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        topLeft: Radius.circular(25)),
                  ),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.13,
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
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.all(6),
                  child: Column(
                    children: [
                      Text(
                        todo!.title!,
                        style: TextStyle(
                            color: themingProvider.appTheme == MyTheme.lightMode
                                ? const Color(0xff060E1E)
                                : Colors.white),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Text(
                        todo!.description!,
                        style: TextStyle(
                            color: themingProvider.appTheme == MyTheme.lightMode
                                ? const Color(0xff060E1E)
                                : Colors.white),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: (){
                    //listProvider.changeDone(todo!.isDone!);
                    markAsUnDone(todo!, context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.height * 0.12,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.blueAccent,
                    ),
                    child: const Text('Done!'),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  void deleteTodo(Todo todo) {
    FirebaseFirestore.instance
        .collection(Todo.collectionNAME)
        .doc(todo.id)
        .delete();
  }

  void markAsDone(Todo todo, BuildContext context){
    FirebaseFirestore.instance
        .collection(Todo.collectionNAME)
        .doc(todo.id)
        .update({
      "done": true,
    }).then(
          (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Marked As Done',
                textAlign: TextAlign.center),
            width: MediaQuery.of(context).size.width * 0.75,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(milliseconds: 500),
          ),
        );
      },
    );
  }

  void markAsUnDone(Todo todo, BuildContext context){
    FirebaseFirestore.instance
        .collection(Todo.collectionNAME)
        .doc(todo.id)
        .update({
      "done": false,
    }).then(
          (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Marked As Not Done',
                textAlign: TextAlign.center),
            width: MediaQuery.of(context).size.width * 0.75,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(milliseconds: 500),
          ),
        );
      },
    );
  }
}
