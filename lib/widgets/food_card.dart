// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:mealselection/components/edit_button.dart';
import 'package:mealselection/resources/firestore_methods.dart';
import 'package:mealselection/responsive/responsive_layout_screen.dart';
import 'package:mealselection/screens/mobile/mobile_meal_menu_screen.dart';
import 'package:mealselection/screens/web/web_meal_menu_screen.dart';
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
              builder: (context) => ResponsiveLayout(
                mobileScreenLayout: MobileMealMenuScreen(
                  foodName: widget.snap['foodName'],
                  foodUrl: widget.snap['foodUrl'],
                  title: widget.title,
                  meal: widget.meal,
                ),
                webScreenLayout: WebMealMenuScreen(
                  foodName: widget.snap['foodName'],
                  foodUrl: widget.snap['foodUrl'],
                  title: widget.title,
                  meal: widget.meal,
                ),
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
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(widget.snap['foodName'],
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 20)),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return EditButton(
                      function: "Edit",
                      foodId: widget.snap['foodId'],
                      foodName: widget.snap['foodName'],
                      foodUrl: widget.snap['foodUrl'],
                    );
                  }),
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
