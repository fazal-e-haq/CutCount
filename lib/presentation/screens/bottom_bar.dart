import 'package:cut_count/presentation/screens/account_screen.dart';
import 'package:cut_count/presentation/screens/add_items_screen.dart';
import 'package:cut_count/presentation/screens/history_screen.dart';
import 'package:cut_count/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BottomBar extends StatefulWidget {
  BottomBar({super.key});

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
        selectedFontSize: 16,
        selectedIconTheme: IconThemeData(size: 32),
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
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Added'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
