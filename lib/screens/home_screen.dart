import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Padding(
        padding: const .symmetric(horizontal: 16.0),
        child: Column(
        children: [
          SizedBox(height: 30,),
          Container(
            height: 200,
            width: 500,
            decoration: BoxDecoration(

        gradient: LinearGradient(colors: [Color(0xffE95401),Colors.deepPurple])
            ),
          )
        ],
        ),
      )),
    );
  }
}
