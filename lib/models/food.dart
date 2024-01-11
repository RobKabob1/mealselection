import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String meal;
  final String foodName;
  final String foodUrl;
  final String foodId;
  final DateTime datePublished;
  final String uid;

  const Food({
    required this.meal,
    required this.foodName,
    required this.foodUrl,
    required this.foodId,
    required this.datePublished,
    required this.uid,
  });

  static Food fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Food(
      meal: snapshot["meal"],
      foodName: snapshot["foodName"],
      foodUrl: snapshot["foodUrl"],
      foodId: snapshot["foodId"],
      datePublished: snapshot["datePublished"],
      uid: snapshot["uid"],
    );
  }

  Map<String, dynamic> toJson() => {
        "meal": meal,
        "foodName": foodName,
        "foodUrl": foodUrl,
        "foodId": foodId,
        "datePublished": datePublished,
        "uid": uid,
      };
}
