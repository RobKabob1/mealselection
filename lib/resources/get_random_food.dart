import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mealselection/screens/meal_menu_screen.dart';

class RandomFood {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void getRandomFoodAndGo(
    context,
    String meal,
  ) async {
    var listOfFood = [];
    var listOfIds = [];
    String randomFood = '';
    String randomFoodUrl = '';

    try {
      await _firestore
          .collection('food')
          .where('meal', isEqualTo: meal)
          .get()
          .then(
        (QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            listOfFood.add(doc['foodName']);
            listOfIds.add(doc['foodUrl']);
          }
          final random = Random();
          int randomInt = random.nextInt(listOfFood.length);
          randomFood = listOfFood[randomInt];
          randomFoodUrl = listOfIds[randomInt];
          listOfFood = [];
          listOfIds = [];
        },
      );
    } catch (err) {
      // showSnackBar(err.toString(), context);
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealMenuScreen(
          foodUrl: randomFoodUrl,
          foodName: randomFood,
          title: meal,
          meal: meal,
        ),
      ),
    );
  }
}
