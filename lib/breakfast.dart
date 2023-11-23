import 'package:flutter/material.dart';

class Breakfast extends StatefulWidget {
  const Breakfast({super.key});

  @override
  State<Breakfast> createState() => _BreakfastState();
}

class _BreakfastState extends State<Breakfast> {
  final items = List<String>.generate(10, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Breakfast'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Image.asset('images/breakfast_taquitos.png'),
              ),
            ],
          ),
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Breakfast Taquitos',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                  child: const Text('Another Random'),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              prototypeItem: ListTile(
                title: Text(items.first),
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    items[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
