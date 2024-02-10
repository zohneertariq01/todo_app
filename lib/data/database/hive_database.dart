import 'package:hive/hive.dart';

class HiveDataBase {
  List<dynamic> todoList = [];

  void createNewList() {
    todoList = [
      {'task': 'Create Pro ToDo app ', 'completed': false},
      {'task': 'Post video on LinkedIn', 'completed': false}
    ];
  }

  final _myBox = Hive.box('testBox');

  void updateDataBase() {
    _myBox.put('ToDoList', todoList);
  }

  void loadData() {
    todoList = _myBox.get('ToDoList');
  }
}
