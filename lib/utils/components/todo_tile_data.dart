import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoTileData extends StatelessWidget {
  final String task;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? delete;
  final Function(BuildContext)? edit;

  const ToDoTileData({
    super.key,
    required this.task,
    required this.taskCompleted,
    required this.onChanged,
    required this.delete,
    required this.edit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: delete,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            SlidableAction(
              onPressed: edit,
              icon: Icons.edit,
              backgroundColor: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.deepOrangeAccent,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: <Widget>[
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.deepOrangeAccent,
              ),
              Text(task,
                  style: taskCompleted
                      ? TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontFamily: GoogleFonts.aBeeZee().fontFamily,
                        )
                      : TextStyle(
                          fontFamily: GoogleFonts.aBeeZee().fontFamily,
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
