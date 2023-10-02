import 'package:flutter/material.dart';

class BottomNavWidget extends StatelessWidget {
  BottomNavWidget({Key? key, required this.section}) : super(key: key);

  final BottomNavWidgetSections section;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: section.index,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,
              color: section.index == 0 ? Colors.purple : Colors.grey,
              size: 30),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,
              color: section.index == 1 ? Colors.purple : Colors.grey,
              size: 30),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history,
              color: section.index == 2 ? Colors.purple : Colors.grey,
              size: 30),
          label: 'History',
        ),
      ],
      selectedItemColor: Colors.purple,
      onTap: (int index) {
        // Handle navigation here
      },
    );
  }
}

enum BottomNavWidgetSections { home, profile, history }
