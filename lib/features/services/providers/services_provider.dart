import 'package:flutter/material.dart';

// Simple in-memory service catalog used by the Services screen.
// In production this is the spot where a repository or database layer can replace mock data.
class ServiceItem {
  ServiceItem({
    required this.name,
    required this.price,
    required this.icon,
    this.note = '',
  });

  final String name;
  final String price;
  final IconData icon;
  final String note;
}

class ServicesProvider with ChangeNotifier {
  // Seed data so the dashboard and services screen look realistic before backend integration.
  final List<ServiceItem> _services = [
    ServiceItem(name: 'Fade Cut', price: 'Rs. 800', icon: Icons.content_cut),
    ServiceItem(name: 'Shave', price: 'Rs. 300', icon: Icons.face_retouching_natural),
    ServiceItem(name: 'Hair Wash', price: 'Rs. 250', icon: Icons.water_drop),
    ServiceItem(name: 'Styling', price: 'Rs. 500', icon: Icons.brush),
  ];

  List<ServiceItem> get services => List.unmodifiable(_services);

  // Insert new services at the top so the newest item is immediately visible.
  void addService(ServiceItem service) {
    _services.insert(0, service);
    notifyListeners();
  }
}
