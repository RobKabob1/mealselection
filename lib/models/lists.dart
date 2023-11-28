import 'package:flutter/material.dart';
import 'food.dart';

class DeliciousChoices extends ChangeNotifier {
  final List<Food> _breakfastMenu = [
    Food(
      name: "Eggs with Beans",
      imagePath: "thepath",
    ),
    Food(
      name: "Coffee w/ Waffles",
      imagePath: "thepath",
    ),
    Food(
      name: "Coffee w/ Muffin",
      imagePath: "thepath",
    ),
    Food(
      name: "Taquitos",
      imagePath: "thepath",
    ),
    Food(
      name: "Pancakes",
      imagePath: "thepath",
    ),
    Food(
      name: "Yogurt Parfait",
      imagePath: "thepath",
    ),
  ];

//getter methods
  List<Food> get breakfastMenu => _breakfastMenu;
}

// var lunchList = [
//   "Turkey Spaghetti",
//   "Turkey Quinoa",
//   "Tomato Basil Soup w/ Chicken",
//   "Beef Broccoli",
//   "Chicken & Veggies",
//   "Salmon & Veggies",
// ];

// var dinnerList = [
//   "Pizza",
//   "Chicken Quesadilla",
// ];

// var restaurantsList = [
//   "Chick fil a",
//   "Island Grill",
//   "Zaab Der",
//   "Fajita Pete's",
//   "Carrabbas",
//   "Pappadeaux's",
//   "Mikoto",
// ];

// var snacksList = [
//   "Boba Tea",
//   "Tiff's Treats",
// ];
