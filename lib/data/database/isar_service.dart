import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/cut_record_model.dart';
import '../models/service_model.dart';

class IsarService {
  // Singleton pattern to prevent multiple instances from opening the db
  static final IsarService _instance = IsarService._internal();
  factory IsarService() => _instance;
  IsarService._internal();

  Isar? _db;

  Future<Isar> get db async {
    if (_db != null) return _db!;
    
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      _db = await Isar.open(
        [ServiceModelSchema, CutRecordModelSchema],
        directory: dir.path,
        inspector: kDebugMode, // Only enable inspector in debug mode
      );
    } else {
      _db = Isar.getInstance();
    }
    return _db!;
  }

  // --- Services Methods ---

  Future<void> saveService(ServiceModel service) async {
    try {
      final isar = await db;
      await isar.writeTxn(() async {
        await isar.serviceModels.put(service);
      });
    } catch (e) {
      debugPrint('Isar error in saveService: $e');
      rethrow;
    }
  }

  Future<void> deleteService(int id) async {
    try {
      final isar = await db;
      await isar.writeTxn(() async {
        await isar.serviceModels.delete(id);
      });
    } catch (e) {
      debugPrint('Isar error in deleteService: $e');
      rethrow;
    }
  }

  Future<List<ServiceModel>> getAllServices() async {
    try {
      final isar = await db;
      return await isar.serviceModels.where().findAll();
    } catch (e) {
      debugPrint('Isar error in getAllServices: $e');
      rethrow;
    }
  }

  // --- Cut Records Methods ---

  Future<void> saveCutRecord(CutRecordModel record) async {
    try {
      final isar = await db;
      await isar.writeTxn(() async {
        await isar.cutRecordModels.put(record);
      });
    } catch (e) {
      debugPrint('Isar error in saveCutRecord: $e');
      rethrow;
    }
  }

  Future<List<CutRecordModel>> getAllCutRecords() async {
    try {
      final isar = await db;
      // Get records sorted by timestamp descending (newest first)
      return await isar.cutRecordModels.where().sortByTimestampDesc().findAll();
    } catch (e) {
      debugPrint('Isar error in getAllCutRecords: $e');
      rethrow;
    }
  }
}
