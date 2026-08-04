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

  // Load existing services or seed the database with initial values
  Future<void> _init() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
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
    } catch (e) {
      errorMessage = 'Failed to load services';
      debugPrint('Error in _init: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<ServiceModel> get services => List.unmodifiable(_services);

  // Add a new service and refresh the list
  Future<void> addService(ServiceModel service) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _isarService.saveService(service);
      _services = await _isarService.getAllServices();
    } catch (e) {
      errorMessage = 'Failed to add service';
      debugPrint('Error in addService: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  // Update an existing service
  Future<void> updateService(ServiceModel service) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _isarService.saveService(service);
      _services = await _isarService.getAllServices();
    } catch (e) {
      errorMessage = 'Failed to update service';
      debugPrint('Error in updateService: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Delete a service by its ID
  Future<void> deleteService(int id) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await _isarService.deleteService(id);
      _services = await _isarService.getAllServices();
    } catch (e) {
      errorMessage = 'Failed to delete service';
      debugPrint('Error in deleteService: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
