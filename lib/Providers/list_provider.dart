import 'package:flutter/material.dart';
import 'package:todo/Models/todo.dart';

class ListProvider extends ChangeNotifier{
  DateTime selectedDate = DateTime.now();

  List<Todo> todos = [];

  changeDate(DateTime date, DateTime events){
    selectedDate = date;
    notifyListeners();
  }

  changeDone(bool value){
    !value;
    notifyListeners();
  }
}