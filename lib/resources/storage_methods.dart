import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //adding image to firebase storage

  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.email!);

    //if it's a post (and not a profile pic), generate a unique ID for the post
    //and the name of the post is this unique id
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    Future<String> downloadUrl = snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // deleting the image from firebase storage
  Future<String> deleteImageInStorage(String foodUrl) async {
    // Reference ref = _storage
    //     .ref()
    //     .child('food')
    //     .child(_auth.currentUser!.email!)
    //     .child(foodId);

    Reference ref = FirebaseStorage.instance.refFromURL(foodUrl);

    await ref.delete();

    return "completed deletion";
  }
}
