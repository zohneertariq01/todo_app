import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogueBox extends StatelessWidget {
  final dynamic controller;
  VoidCallback save;
  DialogueBox({
    super.key,
    required this.controller,
    required this.save,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: TextField(
              controller: controller,
              cursorColor: Colors.deepOrangeAccent,
              decoration: InputDecoration(
                hintText: 'Add new task',
                hintStyle: TextStyle(
                    fontFamily: GoogleFonts.aleo().fontFamily, fontSize: 15),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrangeAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrangeAccent),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: save,
          child: Text(
            'Save',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.deepOrangeAccent,
              fontFamily: GoogleFonts.aleo().fontFamily,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontFamily: GoogleFonts.aleo().fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
