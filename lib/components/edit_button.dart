// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mealselection/resources/firestore_methods.dart';
import 'package:mealselection/utils/utils.dart';

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
  final TextEditingController _textFieldController = TextEditingController();

  void editFoodNameWithSnackBar(
    String foodName,
  ) async {
    try {
      String res = await FirestoreMethods().editFoodName(
        widget.docID,
        _textFieldController.text,
      );

      if (res == "success") {
        setState(() {});
        showSnackBar('Updated ${_textFieldController.text}', context);
      } else {
        setState(() {});
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    Navigator.pop(context);
  }

  Future<void> displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            controller: _textFieldController,
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
                editFoodNameWithSnackBar(_textFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _textFieldController.text = widget.docText;
    return super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldController.dispose();
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
