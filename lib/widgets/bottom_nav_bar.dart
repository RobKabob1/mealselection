import 'package:flutter/material.dart';
import 'package:mealselection/components/add_button.dart';
import 'package:mealselection/resources/get_random_food.dart';
import 'package:mealselection/utils/colors.dart';
import 'package:mealselection/utils/utils.dart';

class BottomNavBar extends StatefulWidget {
  final int screenNumber;
  final String meal;
  const BottomNavBar(
      {super.key, required this.screenNumber, required this.meal});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.screenNumber;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        break;
      case 1:
        showDialog(
            context: context,
            builder: (context) {
              return AddButton(docMeal: widget.meal);
            });
        break;
      case 2:
        if (widget.meal.isEmpty && widget.screenNumber == 3) {
          showSnackBar("Select a meal time from the home screen", context);
        } else if (widget.meal.isEmpty) {
          showSnackBar("Select a meal time", context);
        } else {
          RandomFood().getRandomFoodAndGo(context, widget.meal);
        }
        break;
      case 3:
        Navigator.pushNamedAndRemoveUntil(
            context, "/profile", (route) => false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.refresh),
          label: 'Refresh',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_rounded),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: selectedCardColor,
      onTap: _onItemTapped,
    );
  }
}
