import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealselection/models/food.dart';
import 'package:mealselection/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadFood(
    String meal,
    String foodName,
    Uint8List file,
    String uid,
  ) async {
    String res = "some error occurred";
    try {
      String foodUrl =
          await StorageMethods().uploadImageToStorage('food', file, true);

      String foodId = const Uuid().v1();
      Food post = Food(
        meal: meal,
        foodName: foodName,
        foodUrl: foodUrl,
        foodId: foodId,
        datePublished: DateTime.now(),
        uid: uid,
      );

      _firestore.collection('food').doc(foodId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> editFoodName(
    String foodId,
    String foodName,
  ) async {
    String res = "some error occurred";
    try {
      _firestore.collection('food').doc(foodId).update({
        'foodName': foodName,
      });
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> deleteFoodName(
    String foodId,
  ) async {
    String res = "some error occurred";
    try {
      _firestore.collection('food').doc(foodId).delete();
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
