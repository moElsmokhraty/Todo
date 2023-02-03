import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Models/todo.dart';
import 'package:todo/Providers/list_provider.dart';
import 'package:todo/UI/Tabs/ListTab/calendar.dart';
import 'package:todo/UI/Tabs/ListTab/done_todo_item.dart';
import 'package:todo/UI/Tabs/ListTab/undone_todo_item.dart';

class ListTab extends StatelessWidget {
  ListTab({Key? key}) : super(key: key);

  CollectionReference todosRef = FirebaseFirestore.instance.collection(Todo.collectionNAME);

  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    return Column(
      children: [
        Calendar(),
        const SizedBox(
          height: 5,
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: todosRef.where('date', isEqualTo: '${listProvider.selectedDate.year}-${listProvider.selectedDate.month}-${listProvider.selectedDate.day}').orderBy('isDone', descending: true).snapshots(),
              builder: (context, snapshot){
                if (snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index){
                        return Todo.fromJson(snapshot.data!.docs[index]).isDone == true ?  DoneTodoItem(todo: Todo.fromJson(snapshot.data!.docs[index])) : UnDoneTodoItem(todo: Todo.fromJson(snapshot.data!.docs[index]));
                      });
                } else {
                  return Row(
                    children: const [
                      Spacer(),
                      CircularProgressIndicator(),
                      Spacer()
                    ],
                  );
                }
              }
            )
            )
      ]
    );
  }
}
