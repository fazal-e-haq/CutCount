import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cut_count/presentation/screens/account_screen.dart';
import 'package:cut_count/presentation/screens/add_items_screen.dart';
import 'package:cut_count/presentation/screens/history_screen.dart';
import 'package:cut_count/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

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
      extendBody: true,
      body: view[index],
      bottomNavigationBar: CurvedNavigationBar(
        index: index,
        items: <Widget>[
          Icon(Icons.home, size: 30,color: Colors.white,),
          Icon(Icons.add, size: 30,color: Colors.white,),
          Icon(Icons.history, size: 30,color: Colors.white,),
          Icon(Icons.person, size: 30,color: Colors.white,),
        ],
        color: .new(0xffE95401),
        buttonBackgroundColor: .new(0xffE95401),
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 400),
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}

// BottomNavigationBar(
// type: BottomNavigationBarType.fixed,
// selectedFontSize: 16,
// selectedIconTheme: IconThemeData(size: 32),
// backgroundColor: const Color(0xffE95401),
//
// selectedItemColor: Colors.white,
// unselectedItemColor: Colors.white30,
// currentIndex: index,
//
// onTap: (selectedIndex) {
// setState(() {
// index = selectedIndex;
// });
// },
// items: const [
// BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
// BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Added'),
// BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
// BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
// ],
// ),
