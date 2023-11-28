import 'package:flutter/material.dart';
import 'package:mealselection/lists.dart';

class Breakfast extends StatefulWidget {
  const Breakfast({super.key});

  @override
  State<Breakfast> createState() => _BreakfastState();
}

class _BreakfastState extends State<Breakfast> {
  // final items = List<String>.generate(10, (i) => 'Item $i');
  final items = breakfastList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Breakfast'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[350]),
        child: Column(
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
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      items[index]["name"],
                    ),
                    subtitle: Text(
                      items[index]["path"],
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
