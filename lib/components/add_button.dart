// ignore_for_file: use_build_context_synchronously
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mealselection/models/user.dart';
import 'package:mealselection/providers/user_provider.dart';
import 'package:mealselection/resources/firestore_methods.dart';
import 'package:mealselection/utils/colors.dart';
import 'package:mealselection/utils/utils.dart';
import 'package:provider/provider.dart';

class AddButton extends StatefulWidget {
  final String docMeal;
  const AddButton({
    super.key,
    required this.docMeal,
  });

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  Uint8List? _file;
  final TextEditingController _mealController = TextEditingController();
  bool _isLoading = false;
  static const List<String> list = <String>[
    'Breakfast',
    'Lunch',
    'Dinner',
    'Restaurants',
    'Snacks',
  ];
  String dropdownValue = "";

  void postImage(String uid) async {
    setState(() {
      _isLoading = true;
    });

    String res;
    if (_file == null) {
      res = 'Please choose an image';
      showSnackBar(res, context);
    } else if (_mealController.text.isEmpty) {
      res = "Please enter a meal name";
      showSnackBar(res, context);
    } else {
      try {
        res = await FirestoreMethods().createFood(
          dropdownValue,
          _mealController.text,
          _file!,
          uid,
        );

        if (res == "success") {
          setState(() {});
          showSnackBar('Added food!', context);
          clearImage();
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

  _selectImage(BuildContext context) async {
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

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _mealController.dispose();
  }

  @override
  void initState() {
    if (widget.docMeal.isEmpty) {
      dropdownValue = "Breakfast";
    } else {
      dropdownValue = widget.docMeal;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppUser user = Provider.of<UserProvider>(context).getUser;

    return AlertDialog(
      content: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _file == null
                ? Expanded(
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: IconButton(
                        onPressed: () => _selectImage(context),
                        icon: const Icon(Icons.photo),
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(_file!),
                          fit: BoxFit.contain,
                          alignment: FractionalOffset.topCenter,
                        ),
                      ),
                    ),
                  ),
            DropdownButton<String>(
              value: dropdownValue,
              iconSize: 0,
              isExpanded: true,
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }).toList(),
            ),
            TextField(
              controller: _mealController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: "Meal Name"),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              _mealController.text = "";
              _file = null;
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
                  postImage(user.uid);
                },
              ),
      ],
    );
  }
}
