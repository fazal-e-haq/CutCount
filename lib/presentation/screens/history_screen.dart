import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  late String monthFull = months[DateTime.now().month - 1];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'History',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: .start,
            children: [
              SizedBox(height: size.height * 0.02),
              historyLists(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget historyLists(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: Text(
                  '$monthFull',
                  textAlign: .center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Total Cutting : 10',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Total earing : 1000',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                contentPadding: const EdgeInsets.all(12),
                horizontalTitleGap: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
