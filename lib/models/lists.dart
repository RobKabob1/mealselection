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

  final List<Food> _lunchMenu = [
    Food(
      name: "Turkey Spaghetti",
      imagePath: "images/food/turkey_spaghetti.png",
    ),
    Food(
      name: "Turkey Quinoa",
      imagePath: "images/food/turkey_quinoa.png",
    ),
    Food(
      name: "Tomato Basil Soup w/ Chicken",
      imagePath: "images/food/tomato_basil_soup.png",
    ),
    Food(
      name: "Beef Broccoli",
      imagePath: "images/food/beef_broccoli.png",
    ),
    Food(
      name: "Chicken & Veggies",
      imagePath: "images/food/chicken_and_veggies.png",
    ),
    Food(
      name: "Salmon & Veggies",
      imagePath: "images/food/salmon_and_veggies.png",
    ),
  ];

  final List<Food> _dinnerMenu = [
    Food(
      name: "Pizza",
      imagePath: "images/food/pizza.png",
    ),
    Food(
      name: "Chicken Quesadilla",
      imagePath: "images/food/chicken_quesadilla.png",
    ),
  ];

  final List<Food> _restaurantList = [
    Food(
      name: "Chick-fil-a",
      imagePath: "images/food/chick_fil_a.png",
    ),
    Food(
      name: "Island Grill",
      imagePath: "images/food/island_grill.png",
    ),
    Food(
      name: "Zaab Der",
      imagePath: "images/food/zaab_der.png",
    ),
    Food(
      name: "Fajita Pete's",
      imagePath: "images/food/fajita_petes.png",
    ),
    Food(
      name: "Carrabbas",
      imagePath: "images/food/carrabbas.png",
    ),
    Food(
      name: "Pappadeaux's",
      imagePath: "images/food/pappadeauxs.png",
    ),
    Food(
      name: "Mikoto",
      imagePath: "images/food/mikoto.png",
    ),
  ];

  final List<Food> _snacksList = [
    Food(
      name: "Bobo Tea",
      imagePath: "images/food/bobo_tea.png",
    ),
    Food(
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
