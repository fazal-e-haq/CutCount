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
  final List  newServices = List.generate(24, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
        child: Stack(
          children: [
            // ListView with top padding so it does not go behind container
            Padding(
              padding: const EdgeInsets.only(top: 240, left: 16, right: 16, bottom: 16),
              child: ListView.builder(
                itemCount: newServices.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
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
            // Top Container (fixed)
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Top Container',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Page title above top container
            Positioned(
              top: 16,
              left: 32,
              child: Text(
                'Added Services',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      );

  }
}
