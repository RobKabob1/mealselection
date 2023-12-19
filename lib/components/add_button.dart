import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AddButton extends StatefulWidget {
  final String function;
  final String docMeal;

  const AddButton({super.key, required this.function, required this.docMeal});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  final storageRef = FirebaseStorage.instance.ref();
  PlatformFile? _imageFile;

  Future<void> _pickImage(
      {required void Function(void Function()) setState_}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    //return nothing if they don't choose an image
    if (result == null) return;

    //update the image to display with what the user selected
    setState_(
      () {
        _imageFile = result.files.first;
      },
    );
  }

  Future<void> _uploadImage() async {
    Uint8List? fileBytes;
    String fileName;
    final imageFile = _imageFile;
    if (imageFile != null) {
      fileBytes = imageFile.bytes;
      fileName = imageFile.name;

      // upload file
      await FirebaseStorage.instance
          .ref('uploads/$fileName')
          .putData(fileBytes!);
    }
  }

  Widget _displayCorrectImage() {
    if (_imageFile != null) {
      return Image.memory(
        Uint8List.fromList(_imageFile!.bytes!),
        fit: BoxFit.contain,
      );
    } else {
      return const SizedBox();
    }
  }

  String? valueText;
  @override
  Widget build(BuildContext context) {
    final TextEditingController textFieldController = TextEditingController();
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: (context),
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  content: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: _displayCorrectImage(),
                      ),
                      IconButton(
                        onPressed: () => _pickImage(setState_: setState),
                        icon: const Icon(Icons.photo),
                      ),
                      TextField(
                        controller: textFieldController,
                        decoration:
                            const InputDecoration(hintText: "Meal Name"),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      child: const Text('CANCEL'),
                      onPressed: () {
                        setState(() {
                          textFieldController.text = "";
                          _imageFile = null;
                          Navigator.pop(context);
                        });
                      },
                    ),
                    MaterialButton(
                      child: const Text('OK'),
                      onPressed: () {
                        setState(() {
                          FirebaseFirestore.instance.collection('data').add(
                            {
                              'meal': widget.docMeal,
                              'text': textFieldController.text,
                            },
                          );
                          _uploadImage();
                          textFieldController.text = "";
                          _imageFile = null;
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
