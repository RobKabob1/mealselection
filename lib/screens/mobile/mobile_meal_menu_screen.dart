import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealselection/components/add_button.dart';
import 'package:mealselection/resources/get_random_food.dart';
import 'package:mealselection/responsive/responsive_layout_screen.dart';
import 'package:mealselection/screens/mobile/mobile_user_profile_screen.dart';
import 'package:mealselection/screens/web/web_user_profile_screen.dart';
import 'package:mealselection/utils/colors.dart';
import 'package:mealselection/widgets/food_card.dart';

class MobileMealMenuScreen extends StatefulWidget {
  final String foodName;
  final String foodUrl;
  final String title;
  final String meal;

  const MobileMealMenuScreen(
      {super.key,
      required this.foodName,
      required this.foodUrl,
      required this.title,
      required this.meal});

  @override
  State<MobileMealMenuScreen> createState() => _MobileMealMenuScreenState();
}

class _MobileMealMenuScreenState extends State<MobileMealMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (route) => false);
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResponsiveLayout(
                    mobileScreenLayout: MobileUserProfileScreen(
                        email: FirebaseAuth.instance.currentUser!.email!),
                    webScreenLayout: WebUserProfileScreen(
                        email: FirebaseAuth.instance.currentUser!.email!),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                widget.foodUrl == ''
                    ? Expanded(
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/mealselection.appspot.com/o/defaultPics%2Fno_food.jpg?alt=media&token=45179c12-3f5f-4f1d-a298-d777073d6258',
                            height: 300,
                            fit: BoxFit.fitHeight))
                    : Expanded(
                        child: Image.network(widget.foodUrl,
                            height: 300, fit: BoxFit.fitHeight),
                      ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.foodName == '' ? 'No Food' : widget.foodName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AddButton(docMeal: widget.meal);
                        }),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      RandomFood().getRandomFoodAndGo(context, widget.meal);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection('food')
                    .where('meal', isEqualTo: widget.meal)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  return snapshot.data!.docs.isEmpty
                      ? Center(
                          child: Text(
                              'Add some items to the ${widget.title} list'),
                        )
                      : ListView.builder(
                          // return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) => FoodCard(
                            snap: snapshot.data!.docs[index].data(),
                            meal: widget.meal,
                            title: widget.title,
                            selected: (widget.foodUrl ==
                                    snapshot.data!.docs[index]['foodUrl'])
                                ? true
                                : false,
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}