import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mealselection/models/food.dart';
import 'package:mealselection/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> createFood(
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

      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('food')
          .doc(foodId)
          .set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> updateFoodName(
    String foodId,
    String foodName,
  ) async {
    String res = "some error occurred";
    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('food')
          .doc(foodId)
          .update({
        'foodName': foodName,
      });
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> updatePicture(
    Uint8List file,
    String foodId,
    String oldfoodUrl,
  ) async {
    String res = "some error occurred";
    try {
      //add image to firebase storage
      String foodNewUrl =
          await StorageMethods().uploadImageToStorage('food', file, true);
      //update reference to it in the doc
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('food')
          .doc(foodId)
          .update({
        'foodUrl': foodNewUrl,
      });
      //delete the old image
      await StorageMethods().deleteImageInStorage(oldfoodUrl);
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> updateNameAndPicture(
    Uint8List file,
    String foodId,
    String foodName,
    String oldfoodUrl,
  ) async {
    String res = "some error occurred";
    try {
      //add image to firebase storage
      String foodNewUrl =
          await StorageMethods().uploadImageToStorage('food', file, true);
      //update reference to it in the doc
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('food')
          .doc(foodId)
          .update({
        'foodName': foodName,
        'foodUrl': foodNewUrl,
      });
      //delete the old image
      await StorageMethods().deleteImageInStorage(oldfoodUrl);
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> deleteFoodName(
    String foodId,
    String foodUrl,
  ) async {
    String res = "some error occurred";
    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('food')
          .doc(foodId)
          .delete();
      await StorageMethods().deleteImageInStorage(foodUrl);
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
