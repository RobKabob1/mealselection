import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InputButton extends StatefulWidget {
  final String function;

  const InputButton({super.key, required this.function});

  @override
  State<InputButton> createState() => _InputButtonState();
}

class _InputButtonState extends State<InputButton> {
  Future<void> displayTextInputDialog(BuildContext context) async {
    final TextEditingController textFieldController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: textFieldController,
            decoration: const InputDecoration(hintText: "Meal Name"),
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text('CANCEL'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            MaterialButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  FirebaseFirestore.instance
                      .collection('data')
                      .add({'text': '$valueText'});
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  String? valueText;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        displayTextInputDialog(context);
      },
    );
  }
}
