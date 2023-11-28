import 'package:flutter/material.dart';
import 'food.dart';

class DeliciousChoices extends ChangeNotifier {
  final List<Food> _breakfastMenu = [
    Food(
      name: "Scrambled Eggs with Beans",
      imagePath: "images/food/scrambled_eggs_with_beans.png",
    ),
    Food(
      name: "Coffee w/ Waffles",
      imagePath: "images/food/coffee_with_waffles.png",
    ),
    Food(
      name: "Coffee w/ Muffin",
      imagePath: "images/food/coffee_with_muffin.png",
    ),
    Food(
      name: "Taquitos",
      imagePath: "images/food/breakfast_taquitos.png",
    ),
    Food(
      name: "Pancakes",
      imagePath: "images/food/pancakes.png",
    ),
    Food(
      name: "Yogurt Parfait",
      imagePath: "images/food/yogurt_parfait.png",
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
