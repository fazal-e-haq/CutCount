import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;

  final List<Widget> view = [
    // HomeScreen(),
    // AddItemsScreen(),
    // HistoryScreen(),
    // AccountScreen(),
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

