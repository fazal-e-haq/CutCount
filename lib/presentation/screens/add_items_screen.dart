import 'package:flutter/material.dart';

class AddItemsScreen extends StatelessWidget {
  AddItemsScreen({super.key});

  // Current timestamp formatted
  final DateTime now = DateTime.now();
  String two(int n) => n.toString().padLeft(2, '0');

  late final String formatted =
      '${two(DateTime.now().day)}-${two(DateTime.now().month)}-${DateTime.now().year} '
      'at ${two(DateTime.now().hour)}:${two(DateTime.now().minute)}:${two(DateTime.now().second)}';

  // Sample data
  final List newServices = List.generate(24, (index) => index + 1);

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
        title:  Text(

          'Added Services',
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
              Expanded(
                child: ListView.builder(
                  itemCount: newServices.length,
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
                            'Service ${newServices[index]}',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          subtitle: Text(formatted),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
