import 'package:cut_count/presentation/widgets/cards_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List da = [1, 'Adas', 2, 3, 4, 5, 4, 3, 2, 21, 2, 2];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'CutCount',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                // Top greeting container
                MainBoards(),
                SizedBox(height: size.height * 0.02),
                // Services title
                Text(
                  'Services',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Wrap(
                  runSpacing: 5,
                  spacing: 8,
                  direction: .horizontal,
                  crossAxisAlignment: .center,
                  children: List.generate(da.length, (index) {
                    return CardsWidget(
                      height: size.height * 0.2,
                      width: size.width * 0.445,

                      color: Colors.red,
                      child: Text('data'),
                    );
                  }),
                ),
                // List of services

                // Services list using ListView.builder
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainBoards extends StatelessWidget {
  const MainBoards({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        //
        CardsWidget(
          height: size.height * 0.2,
          width: size.width * 0.43,
          color: Color(0xFFFFF9F3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 30),
              Text('Add cut', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
        SizedBox(width: 10),
        //
        Column(
          children: [
            CardsWidget(
              height: size.height * 0.095,
              width: size.width * 0.43,
              color: Color(0xFFFFF4EA),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '50',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontFamily: 'Unbounded',
                    ),
                  ),
                  Text(
                    'Total Cutts',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            SizedBox(height: 5),
            CardsWidget(
              height: size.height * 0.095,
              width: size.width * 0.43,
              color: Color(0xFFFFF4EA),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '50',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontFamily: 'Unbounded',
                    ),
                  ),
                  Text(
                    'Total amount',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
