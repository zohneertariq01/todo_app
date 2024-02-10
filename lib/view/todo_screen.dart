import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/data/database/hive_database.dart';
import 'package:todo_app/utils/components/dialogue_box.dart';
import 'package:todo_app/utils/components/new_box.dart';
import 'package:todo_app/utils/components/todo_tile_data.dart';
import 'package:todo_app/utils/routes/routes_name.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view_model/user_view_model.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _myBox = Hive.box('testBox');
  HiveDataBase db = HiveDataBase();
  TextEditingController _controller = TextEditingController();
  TextEditingController newController = TextEditingController();

  void onChanged(bool? value, int index) {
    setState(() {
      db.todoList[index]['completed'] = !db.todoList[index]['completed'];
    });
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogueBox(
          controller: _controller,
          save: onSave,
        );
      },
    );
  }

  void isEdit(int index) {
    String initialText = db.todoList[index]['task']; // Get initial text
    newController.text = initialText; // Set initial text to the controller
    showDialog(
      context: context,
      builder: (context) {
        return NewBox(
          controller: newController,
          update: () {
            onEdit(index);
          },
        );
      },
    );
    db.updateDataBase();
  }

  void onEdit(int index) {
    setState(() {
      db.todoList[index]['task'] = newController.text;
      newController.clear();
    });
    db.updateDataBase();
    Navigator.pop(context);
  }

  void onSave() {
    if (_controller.text.isEmpty) {
      Utils.flushBarMessage('Please enter your task!', context);
    } else {
      setState(() {
        db.todoList.add({'task': _controller.text, 'completed': false});
        _controller.clear();
      });
      db.updateDataBase();
      Navigator.pop(context);
    }
  }

  void onDelete(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_myBox.get('ToDoList') == null) {
      db.createNewList();
    } else {
      db.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        title: Text(
          'Todo Pro',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.aleo().fontFamily,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Consumer<UserViewModel>(
              builder: (context, value, child) {
                return IconButton(
                  onPressed: () {
                    value.removeUser().then((value) async {
                      SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      sp.setBool('onBoarding_data', false);
                      Navigator.pushNamed(context, RoutesName.intro);
                    });
                  },
                  icon: Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 20),
        shrinkWrap: true,
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return ToDoTileData(
            task: db.todoList[index]['task'],
            taskCompleted: db.todoList[index]['completed'],
            onChanged: (value) {
              onChanged(value, index);
            },
            delete: (value) {
              onDelete(index);
            },
            edit: (value) {
              isEdit(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        shape: CircleBorder(),
        child: IconButton(
          onPressed: () {
            createNewTask();
          },
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
