import 'package:cut_count/screens/account_screen.dart';
import 'package:cut_count/screens/add_items_screen.dart';
import 'package:cut_count/screens/history_screen.dart';
import 'package:cut_count/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;

  final List<Widget> view = [
    HomeScreen(),
    AddItemsScreen(),
    HistoryScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: view[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xffE95401),

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white30,
        currentIndex: index,

        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
