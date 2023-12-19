import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditButton extends StatefulWidget {
  final String function;
  final String docID;
  final String docText;

  const EditButton({
    super.key,
    required this.function,
    required this.docID,
    required this.docText,
  });

  @override
  State<EditButton> createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  final TextEditingController textFieldController = TextEditingController();

  Future<void> displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
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
                      .doc(widget.docID)
                      .update({
                    'text': textFieldController.text,
                  });
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    textFieldController.text = widget.docText;
    return super.initState();
  }

  String? valueText;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        displayTextInputDialog(context);
      },
    );
  }
}
