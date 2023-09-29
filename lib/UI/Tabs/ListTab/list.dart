import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Models/todo.dart';
import 'package:todo/Providers/list_provider.dart';
import 'package:todo/UI/Tabs/ListTab/calendar.dart';
import 'package:todo/UI/Tabs/ListTab/done_todo_item.dart';
import 'package:todo/UI/Tabs/ListTab/undone_todo_item.dart';

class ListTab extends StatelessWidget {
  const ListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodosProvider listProvider = Provider.of(context);
    return Column(
      children: [
        const Calendar(),
        const SizedBox(height: 5),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: listProvider.todosRef
                .where(
                  'date',
                  isEqualTo:
                      '${listProvider.calendarDate.year}-${listProvider.calendarDate.month}-${listProvider.calendarDate.day}',
                )
                .orderBy('isDone', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Todo.fromJson(snapshot.data!.docs[index]).isDone!
                        ? DoneTodoItem(
                            todo: Todo.fromJson(snapshot.data!.docs[index]),
                          )
                        : UnDoneTodoItem(
                            todo: Todo.fromJson(snapshot.data!.docs[index]),
                          );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        )
      ],
    );
  }
}
