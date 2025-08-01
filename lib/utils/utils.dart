import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

Future<Uint8List?>? pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  Uint8List? finalFile;
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    finalFile = await file.readAsBytes();
  }
  return finalFile;
}

void showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
