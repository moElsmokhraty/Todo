import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  static String collectionNAME = 'todos';
  late String? id;
  late String? title;
  late String? description;
  late String? date;
  late bool? isDone;

  Todo({
    this.id = '',
    required this.title,
    required this.description,
    required this.date,
    required this.isDone,
  });

  Todo.fromJson(dynamic json) {
    id = json['id'] as String;
    title =  json['title'] as String;
    description = json['description'] as String;
    date = json['date'] as String;
    isDone = json['isDone'] as bool;
  }

  Map<String, dynamic> toJson() {
  final map = <String, dynamic>{};
  map['id'] = id;
  map['title'] = title;
  map['description'] = description;
  map['date'] = date;
  map['isDone'] = isDone;
  return map;
  }

  static CollectionReference<Todo> withConverter(){
    return FirebaseFirestore.instance.collection(Todo.collectionNAME).withConverter<Todo>(
      fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
      toFirestore: (model, _) => model.toJson(),
    );
  }
}
