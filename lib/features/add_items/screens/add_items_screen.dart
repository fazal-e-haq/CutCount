import 'package:flutter/material.dart';

// Add Items tab — used to log a new haircut service
class AddItemsScreen extends StatelessWidget {
  const AddItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Service')),
      body: const Center(child: Text('Add Items Screen')),
    );
  }
}
