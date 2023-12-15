import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealselection/components/input_button.dart';
import 'package:mealselection/models/food.dart';
import 'package:mealselection/models/lists.dart';
import 'package:provider/provider.dart';

class Breakfast extends StatefulWidget {
  final Food food;
  final String title;

  const Breakfast({super.key, required this.food, required this.title});

  @override
  State<Breakfast> createState() => _BreakfastState();
}

class _BreakfastState extends State<Breakfast> {
  final Stream<QuerySnapshot> _dataStream =
      FirebaseFirestore.instance.collection('data').snapshots();

  @override
  Widget build(BuildContext context) {
    //get the breakfast menu and choose a random item
    final items = context.read<DeliciousChoices>();
    final int randomBreakfastIndex;
    if (items.breakfastMenu.isEmpty) {
      randomBreakfastIndex = 0;
    } else {
      randomBreakfastIndex = Random().nextInt(items.breakfastMenu.length);
    }
    setState(() {
      randomBreakfastIndex;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[350],
        title: Text(
          widget.title,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: 'Times New Roman'),
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
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(
                      title: const Text('User Profile'),
                    ),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      })
                    ],
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset('images/icons/web.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[350]),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                    widget.food.imagePath,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.food.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: InputButton(function: "Add"),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Breakfast(
                            food: items.breakfastMenu[randomBreakfastIndex],
                            title: 'Breakfast',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _dataStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  return ReorderableListView(
                    autoScrollerVelocityScalar: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    //figure this reorder logic
                    //https://stackoverflow.com/questions/61322824/firebase-collection-into-reorderablelistview
                    onReorder: (int oldIndex, int newIndex) {},
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Card(
                        key: Key(document.id),
                        color: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: SizedBox(
                                  height: 50,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(data['text'],
                                        style: const TextStyle(fontSize: 20)),
                                  ),
                                ),
                              ),
                              IconButton(
                                  //functionality to delete
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete)),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),

            // Expanded(
            //   child: ReorderableListView(
            //     autoScrollerVelocityScalar: 100,
            //     padding: const EdgeInsets.symmetric(horizontal: 10),
            //     onReorder: (int oldIndex, int newIndex) {
            //       setState(
            //         () {
            //           if (oldIndex < newIndex) {
            //             newIndex -= 1;
            //           }
            //           final Food item = items.breakfastMenu.removeAt(oldIndex);
            //           items.breakfastMenu.insert(newIndex, item);
            //         },
            //       );
            //     },
            //     children: [
            //       for (int index = 0;
            //           index < items.breakfastMenu.length;
            //           index += 1)
            //         Card(
            //           key: Key('$index'),
            //           color: Colors.grey[200],
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10.0),
            //           ),
            //           child: InkWell(
            //             onTap: () {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (context) => Breakfast(
            //                     food: items.breakfastMenu[index],
            //                     title: 'Breakfast',
            //                   ),
            //                 ),
            //               );
            //             },
            //             child: Row(
            //               children: [
            //                 Expanded(
            //                   flex: 6,
            //                   child: SizedBox(
            //                     height: 50,
            //                     child: Container(
            //                       alignment: Alignment.center,
            //                       child: Text(items.breakfastMenu[index].name,
            //                           style: const TextStyle(fontSize: 20)),
            //                     ),
            //                   ),
            //                 ),
            //                 IconButton(
            //                     onPressed: () {
            //                       items.breakfastMenu.removeAt(index);
            //                       setState(() {});
            //                     },
            //                     icon: const Icon(Icons.delete)),
            //                 const Padding(
            //                   padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
