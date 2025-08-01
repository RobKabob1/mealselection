// ignore_for_file: use_build_context_synchronously
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mealselection/resources/firestore_methods.dart';
import 'package:mealselection/utils/colors.dart';
import 'package:mealselection/utils/utils.dart';

class EditButton extends StatefulWidget {
  final String function;
  final String foodId;
  final String foodName;
  final String foodUrl;

  const EditButton({
    super.key,
    required this.function,
    required this.foodId,
    required this.foodName,
    required this.foodUrl,
  });

  @override
  State<EditButton> createState() => _EditButtonState();
}

class _EditButtonState extends State<EditButton> {
  Uint8List? _file;
  final TextEditingController _textFieldController = TextEditingController();
  bool _isLoading = false;

  void editFoodNameWithSnackBar(
    String foodName,
  ) async {
    setState(() {
      _isLoading = true;
    });

    String res;
    if (_textFieldController.text.isEmpty) {
      res = "Please enter a meal name";
      showSnackBar(res, context);
    } else if (_file == null && _textFieldController.text == widget.foodName) {
      res = "No changes made";
      showSnackBar(res, context);
      Navigator.pop(context);
    } else if (_file == null && _textFieldController.text != widget.foodName) {
      try {
        res = await FirestoreMethods().updateFoodName(
          widget.foodId,
          _textFieldController.text,
        );
        if (res == "success") {
          setState(() {});
          showSnackBar('Updated ${_textFieldController.text} name', context);
        } else {
          setState(() {});
          showSnackBar(res, context);
        }
      } catch (e) {
        showSnackBar(e.toString(), context);
      }
      Navigator.pop(context);
    } else if (_file != null && _textFieldController.text == widget.foodName) {
      try {
        res = await FirestoreMethods()
            .updatePicture(_file!, widget.foodId, widget.foodUrl);
        if (res == "success") {
          setState(() {});
          showSnackBar('Updated ${_textFieldController.text} picture', context);
        } else {
          setState(() {});
          showSnackBar(res, context);
        }
      } catch (e) {
        showSnackBar(e.toString(), context);
      }
      Navigator.pop(context);
    } else {
      try {
        res = await FirestoreMethods().updateNameAndPicture(
            _file!, widget.foodId, _textFieldController.text, widget.foodUrl);
        if (res == "success") {
          setState(() {});
          showSnackBar(
              'Updated ${_textFieldController.text} name and picture', context);
        } else {
          setState(() {});
          showSnackBar(res, context);
        }
      } catch (e) {
        showSnackBar(e.toString(), context);
      }
      Navigator.pop(context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<Future> _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Choose a picture'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List? file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List? file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    _textFieldController.text = widget.foodName;
    return super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _file == null
                            ? NetworkImage(widget.foodUrl) as ImageProvider
                            : MemoryImage(_file!),
                        // _file == null ? Image.network(widget.docUrl) : MemoryImage(_file!),
                        fit: BoxFit.contain,
                        alignment: FractionalOffset.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 180,
                    child: IconButton(
                      onPressed: () => _selectImage(context),
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "Meal Name"),
            ),
          ],
        ),
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
        _isLoading
            ? MaterialButton(
                child: const CircularProgressIndicator(
                  color: primaryColor,
                ),
                onPressed: () {},
              )
            : MaterialButton(
                child: const Text('OK'),
                onPressed: () {
                  editFoodNameWithSnackBar(_textFieldController.text);
                },
              ),
      ],
    );
  }
}
