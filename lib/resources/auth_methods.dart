import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mealselection/models/user.dart';
import 'package:mealselection/resources/firestore_methods.dart';
import 'package:mealselection/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<AppUser> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.email).get();

    return AppUser.fromSnap(documentSnapshot);
  }

  // Signing Up User
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // add profile image
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        AppUser user = AppUser(
          email: email,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
        );
        // add user in our database
        await _firestore
            .collection("users")
            .doc(cred.user!.email)
            .set(user.toJson());
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> deleteUserAccount() async {
    String res = "Some error Occurred";
    try {
      // delete user's profile picture in Storage
      await StorageMethods().deleteProfileImageInStorage();
      // delete user's foods
      // Firebase won't let you delete an entire folder, so we have to iterate through each of the pictures
      // you have to delete the picture in Storage AND delete the food's Firestore Database doc
      await _firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection("food")
          .get()
          .then(
        (querySnapshot) async {
          for (var docSnapshot in querySnapshot.docs) {
            await FirestoreMethods().deleteFoodName(
              docSnapshot['foodId'],
              docSnapshot['foodUrl'],
            );
          }
        },
      );
      // delete user main Firestore Database doc
      await _firestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .delete();
      // delete user's profile in Authentication
      await FirebaseAuth.instance.currentUser!.delete();

      res = "success";
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<String> resetPassword({required String email}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: email);
        res = "success";
      } else {
        res = "Please enter an email";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> validateResetPasswordCode({required String code}) async {
    String res = "Some error occurred";
    return res;
  }
}
