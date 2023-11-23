import 'package:flutter/material.dart';
import 'package:mealselection/breakfast.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //breakfast
            Row(
              children: [
                Expanded(
                  child: IconButton(
                    iconSize: 20,
                    icon: Image.asset(
                      'images/breakfast.png',
                      width: 500,
                      height: 100,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Breakfast(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            //lunch
            Row(
              children: [
                Expanded(
                  child: IconButton(
                    iconSize: 20,
                    icon:
                        Image.asset('images/lunch.png', fit: BoxFit.scaleDown),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            //dinner
            Row(
              children: [
                Expanded(
                  child: IconButton(
                    iconSize: 20,
                    icon: Image.asset('images/dinner.png', fit: BoxFit.contain),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
