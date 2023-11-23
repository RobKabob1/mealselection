import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Meal Selection'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              //mainAxisAlignment: Center,
              children: [
                Expanded(
                  child: IconButton(
                    iconSize: 20,
                    icon: Image.asset(
                      'images/breakfast.png',
                      width: 500,
                      height: 100,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            //lunch
            Row(
              //mainAxisAlignment: Center,
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
              //mainAxisAlignment: Center,
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
