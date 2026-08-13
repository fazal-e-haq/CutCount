import 'package:flutter/material.dart';
import '../../../data/database/isar_service.dart';
import '../../../data/models/service_model.dart';

class ServicesProvider with ChangeNotifier {
  final IsarService _isarService;
  List<ServiceModel> _services = [];

  bool isLoading = false;
  String? errorMessage;

  ServicesProvider(this._isarService) {
    _init();
  }

  // ---------------------------------------------------------------------------
  // Shared helper – wraps every async operation with loading state, error
  // handling, and notifyListeners(). Eliminates the repeated boilerplate.
  // ---------------------------------------------------------------------------
  Future<void> _guard(String errorMsg, Future<void> Function() action) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await action();
    } catch (e) {
      errorMessage = errorMsg;
      debugPrint('ServicesProvider error ($errorMsg): $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Load existing services or seed the database with initial values
  Future<void> _init() => _guard('Failed to load services', () async {
    await _isarService.db;
    _services = await _isarService.getAllServices();

    if (_services.isEmpty) {
      final defaults = [
        ServiceModel()..name = 'Fade Cut'..price = 800..iconCodePoint = Icons.content_cut.codePoint,
        ServiceModel()..name = 'Shave'..price = 300..iconCodePoint = Icons.face_retouching_natural.codePoint,
        ServiceModel()..name = 'Hair Wash'..price = 250..iconCodePoint = Icons.water_drop.codePoint,
        ServiceModel()..name = 'Styling'..price = 500..iconCodePoint = Icons.brush.codePoint,
      ];
      for (var s in defaults) {
        await _isarService.saveService(s);
      }
      _services = await _isarService.getAllServices();
    }
  });

  List<ServiceModel> get services => List.unmodifiable(_services);

  /// Add a new service and refresh the list.
  Future<void> addService(ServiceModel service) =>
      _guard('Failed to add service', () async {
        await _isarService.saveService(service);
        _services = await _isarService.getAllServices();
      });

  /// Update an existing service.
  Future<void> updateService(ServiceModel service) =>
      _guard('Failed to update service', () async {
        await _isarService.saveService(service);
        _services = await _isarService.getAllServices();
      });

  /// Delete a service by its ID.
  Future<void> deleteService(int id) =>
      _guard('Failed to delete service', () async {
        await _isarService.deleteService(id);
        _services = await _isarService.getAllServices();
      });
}
