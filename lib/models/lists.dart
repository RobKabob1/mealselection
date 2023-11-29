import 'package:flutter/material.dart';
import 'food.dart';

class DeliciousChoices extends ChangeNotifier {
  final List<Food> _breakfastMenu = [
    Food(
      key: 1,
      name: "Scrambled Eggs with Beans",
      imagePath: "images/food/scrambled_eggs_with_beans.png",
    ),
    Food(
      key: 2,
      name: "Coffee w/ Waffles",
      imagePath: "images/food/coffee_with_waffles.png",
    ),
    Food(
      key: 3,
      name: "Coffee w/ Muffin",
      imagePath: "images/food/coffee_with_muffin.png",
    ),
    Food(
      key: 4,
      name: "Taquitos",
      imagePath: "images/food/breakfast_taquitos.png",
    ),
    Food(
      key: 5,
      name: "Pancakes",
      imagePath: "images/food/pancakes.png",
    ),
    Food(
      key: 6,
      name: "Yogurt Parfait",
      imagePath: "images/food/yogurt_parfait.png",
    ),
  ];

  final List<Food> _lunchMenu = [
    Food(
      key: 1,
      name: "Turkey Spaghetti",
      imagePath: "images/food/turkey_spaghetti.png",
    ),
    Food(
      key: 1,
      name: "Turkey Quinoa",
      imagePath: "images/food/turkey_quinoa.png",
    ),
    Food(
      key: 1,
      name: "Tomato Basil Soup w/ Chicken",
      imagePath: "images/food/tomato_basil_soup.png",
    ),
    Food(
      key: 1,
      name: "Beef Broccoli",
      imagePath: "images/food/beef_broccoli.png",
    ),
    Food(
      key: 1,
      name: "Chicken & Veggies",
      imagePath: "images/food/chicken_and_veggies.png",
    ),
    Food(
      key: 1,
      name: "Salmon & Veggies",
      imagePath: "images/food/salmon_and_veggies.png",
    ),
  ];

  final List<Food> _dinnerMenu = [
    Food(
      key: 1,
      name: "Pizza",
      imagePath: "images/food/pizza.png",
    ),
    Food(
      key: 1,
      name: "Chicken Quesadilla",
      imagePath: "images/food/chicken_quesadilla.png",
    ),
  ];

  final List<Food> _restaurantList = [
    Food(
      key: 1,
      name: "Chick-fil-a",
      imagePath: "images/food/chick_fil_a.png",
    ),
    Food(
      key: 1,
      name: "Island Grill",
      imagePath: "images/food/island_grill.png",
    ),
    Food(
      key: 1,
      name: "Zaab Der",
      imagePath: "images/food/zaab_der.png",
    ),
    Food(
      key: 1,
      name: "Fajita Pete's",
      imagePath: "images/food/fajita_petes.png",
    ),
    Food(
      key: 1,
      name: "Carrabbas",
      imagePath: "images/food/carrabbas.png",
    ),
    Food(
      key: 1,
      name: "Pappadeaux's",
      imagePath: "images/food/pappadeauxs.png",
    ),
    Food(
      key: 1,
      name: "Mikoto",
      imagePath: "images/food/mikoto.png",
    ),
  ];

  final List<Food> _snacksList = [
    Food(
      key: 1,
      name: "Bobo Tea",
      imagePath: "images/food/bobo_tea.png",
    ),
    Food(
      key: 1,
      name: "Tiff's Treats",
      imagePath: "images/food/tiffs_treats.png",
    ),
  ];

//getter methods
  List<Food> get breakfastMenu => _breakfastMenu;
  List<Food> get lunchMenu => _lunchMenu;
  List<Food> get dinnerMenu => _dinnerMenu;
  List<Food> get restaurantList => _restaurantList;
  List<Food> get snacksList => _snacksList;
}
