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
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[350]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //breakfast
              Expanded(
                child: IconButton(
                  iconSize: 20,
                  icon: Image.asset(
                    'images/breakfast.png',
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
              //lunch
              Expanded(
                child: IconButton(
                  iconSize: 20,
                  icon: Image.asset('images/lunch.png'),
                  onPressed: () {},
                ),
              ),
              //dinner
              Expanded(
                child: IconButton(
                  iconSize: 20,
                  icon: Image.asset('images/dinner.png'),
                  onPressed: () {},
                ),
              ),
              //restaurants
              Expanded(
                child: IconButton(
                  iconSize: 20,
                  icon: Image.asset(
                    'images/restaurants.png',
                  ),
                  onPressed: () {},
                ),
              ),
              //snacks
              Expanded(
                child: IconButton(
                  iconSize: 20,
                  icon: Image.asset('images/snacks.png'),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
