// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:mealselection/components/edit_button.dart';
import 'package:mealselection/resources/firestore_methods.dart';
import 'package:mealselection/screens/meal_menu_screen.dart';
import 'package:mealselection/utils/colors.dart';

class FoodCard extends StatefulWidget {
  final snap;
  final String meal;
  final String title;
  final bool selected;

  const FoodCard(
      {super.key,
      required this.snap,
      required this.meal,
      required this.title,
      required this.selected});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  void deleteFoodNameWithSnackBar(
    String foodId,
    String foodName,
    String foodUrl,
  ) async {
    setState(() {});
    try {
      String res = await FirestoreMethods().deleteFoodName(
        foodId,
        foodUrl,
      );

      if (res != "success") {
        debugPrint(res);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(widget.snap['foodId']),
      color: widget.selected ? selectedCardColor : cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealMenuScreen(
                foodName: widget.snap['foodName'],
                foodUrl: widget.snap['foodUrl'],
                title: widget.title,
                meal: widget.meal,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: SizedBox(
                height: 50,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(widget.snap['foodName'],
                      style: const TextStyle(fontSize: 20)),
                ),
              ),
            ),
            EditButton(
              function: "Edit",
              docID: widget.snap['foodId'],
              docText: widget.snap['foodName'],
            ),
            IconButton(
              onPressed: () {
                deleteFoodNameWithSnackBar(widget.snap['foodId'],
                    widget.snap['foodName'], widget.snap['foodUrl']);
              },
              icon: const Icon(Icons.delete),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
            ),
          ],
        ),
      ),
    );
  }
}
