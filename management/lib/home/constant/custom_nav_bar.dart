import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Dashboard",
            backgroundColor: Colors.blueAccent),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), label: "Calendar"),
      ],
    );
  }
}
