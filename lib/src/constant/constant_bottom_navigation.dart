import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget constantBottomNavigation(int selectedIndex) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard),
        label: 'Dashboard',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_box_outlined),
        label: 'Create Ticket',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'User',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
    ],
    currentIndex: selectedIndex,
    selectedItemColor: const Color(0xff1616e5),
    unselectedItemColor: const Color(0xff949495),
    onTap: (int index) {},
  );
}
