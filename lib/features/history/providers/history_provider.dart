import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/database/isar_service.dart';
import '../../../data/models/cut_record_model.dart';
import '../../../data/models/service_model.dart';

// UI models mapping
class HistoryItem {
  HistoryItem({
    required this.title,
    required this.amount,
    required this.time,
  });

  final String title;
  final String amount;
  final String time;
}

class MonthHistory {
  MonthHistory({
    required this.monthLabel,
    required this.totalCuts,
    required this.totalAmount,
    required this.days,
  });

  final String monthLabel;
  final String totalCuts;
  final String totalAmount;
  final List<HistoryItem> days;
}

class HistoryProvider with ChangeNotifier {
  final IsarService _isarService;
  bool showMonthly = true;

  bool isLoading = false;
  String? errorMessage;

  int todayCutsCount = 0;
  int todayAmountValue = 0;

  // All-time aggregates used by the ProfileScreen stat cards.
  int allTimeCutsCount = 0;
  int allTimeAmountValue = 0;

  // Monthly trend data consumed by the ProfileScreen line charts.
  // Each entry maps a month label (e.g. 'Jan') to a total value.
  List<MapEntry<String, int>> monthlyTrendCuts = [];
  List<MapEntry<String, int>> monthlyTrendAmount = [];

  int currentMonthCutsCount = 0;
  int currentMonthAmountValue = 0;

  final List<HistoryItem> _todayHistory = [];
  final List<MonthHistory> _monthlyHistory = [];
  final List<MapEntry<String, double>> _weeklyEarnings = [];

  HistoryProvider(this._isarService) {
    _init();
  }

  Future<void> _init() async {
    await _isarService.db;
    await fetchHistory();
  }

  // Refreshes data from Isar DB and groups it for the UI
  Future<void> fetchHistory() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final records = await _isarService.getAllCutRecords();
      
      _todayHistory.clear();
      _monthlyHistory.clear();
      todayCutsCount = 0;
      todayAmountValue = 0;
      currentMonthCutsCount = 0;
      currentMonthAmountValue = 0;
      allTimeCutsCount = 0;
      allTimeAmountValue = 0;

      final now = DateTime.now();
      
      // Initialize last 7 days map for the chart
      final Map<String, double> last7DaysMap = {};
      for (int i = 6; i >= 0; i--) {
        final d = now.subtract(Duration(days: i));
        last7DaysMap[DateFormat('yyyy-MM-dd').format(d)] = 0.0;
      }
      
      // Group records by month (e.g. "July 2026")
      final Map<String, List<CutRecordModel>> monthGroups = {};

      for (var record in records) {
        // Calculate today's cuts and amount
        if (record.timestamp.year == now.year &&
            record.timestamp.month == now.month &&
            record.timestamp.day == now.day) {
          
          todayCutsCount += 1;
          todayAmountValue += record.price.toInt();
          
          _todayHistory.add(HistoryItem(
            title: record.serviceName,
            amount: '${record.price.toInt()}',
            time: DateFormat.jm().format(record.timestamp),
          ));
        }

        // Calculate current month's cuts and amount
        if (record.timestamp.year == now.year &&
            record.timestamp.month == now.month) {
          currentMonthCutsCount += 1;
          currentMonthAmountValue += record.price.toInt();
        }

        // Add to last 7 days map
        final dateKey = DateFormat('yyyy-MM-dd').format(record.timestamp);
        if (last7DaysMap.containsKey(dateKey)) {
          last7DaysMap[dateKey] = last7DaysMap[dateKey]! + record.price;
        }

        // Grouping by Month for the monthly history screen
        final monthLabel = DateFormat('MMMM yyyy').format(record.timestamp);
        if (!monthGroups.containsKey(monthLabel)) {
          monthGroups[monthLabel] = [];
        }
        monthGroups[monthLabel]!.add(record);
      }

      // Convert monthGroups to the MonthHistory objects needed by UI
      for (var entry in monthGroups.entries) {
        final monthLabel = entry.key;
        final monthRecords = entry.value;

        int totalAmount = 0;
        
        // Group further by day inside each month
        final Map<String, List<CutRecordModel>> dayGroups = {};
        for (var record in monthRecords) {
          totalAmount += record.price.toInt();
          final dayLabel = DateFormat('dd MMM').format(record.timestamp);
          if (!dayGroups.containsKey(dayLabel)) {
            dayGroups[dayLabel] = [];
          }
          dayGroups[dayLabel]!.add(record);
        }

        final List<HistoryItem> daysList = [];
        for (var dayEntry in dayGroups.entries) {
          final dayLabel = dayEntry.key;
          final dayRecords = dayEntry.value;
          final dayAmount = dayRecords.fold<double>(0, (sum, item) => sum + item.price).toInt();
          daysList.add(HistoryItem(
            title: dayLabel,
            amount: '$dayAmount',
            time: '${dayRecords.length} cuts',
          ));
        }

        _monthlyHistory.add(MonthHistory(
          monthLabel: monthLabel,
          totalCuts: '${monthRecords.length} cuts',
          totalAmount: '$totalAmount',
          days: daysList,
        ));
      }

      // Finalize weekly earnings for the chart
      _weeklyEarnings.clear();
      for (var entry in last7DaysMap.entries) {
        final date = DateFormat('yyyy-MM-dd').parse(entry.key);
        _weeklyEarnings.add(MapEntry(DateFormat('EEE').format(date), entry.value));
      }

      // --- All-time stats & monthly trend for ProfileScreen ---------------
      allTimeCutsCount = records.length;
      allTimeAmountValue =
          records.fold<int>(0, (sum, r) => sum + r.price.toInt());

      // Build monthly trend lists from monthGroups (already computed above).
      // We use short month names (e.g. 'Jan') for chart x-axis labels.
      monthlyTrendCuts = [];
      monthlyTrendAmount = [];
      for (final entry in monthGroups.entries) {
        // entry.key is like "July 2026" – parse back to get a short label.
        final parsed = DateFormat('MMMM yyyy').parse(entry.key);
        final shortLabel = DateFormat('MMM').format(parsed);
        monthlyTrendCuts.add(MapEntry(shortLabel, entry.value.length));
        final amount =
            entry.value.fold<int>(0, (sum, r) => sum + r.price.toInt());
        monthlyTrendAmount.add(MapEntry(shortLabel, amount));
      }
    } catch (e) {
      errorMessage = 'Failed to load history';
      debugPrint('Error in fetchHistory: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<HistoryItem> get todayHistory => List.unmodifiable(_todayHistory);
  List<MonthHistory> get monthlyHistory => List.unmodifiable(_monthlyHistory);
  List<MapEntry<String, double>> get weeklyEarnings => List.unmodifiable(_weeklyEarnings);

  void toggleView(bool monthly) {
    showMonthly = monthly;
    notifyListeners();
  }

  // Record a new cut when a service is tapped
  Future<void> recordService(ServiceModel service) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final record = CutRecordModel()
        ..serviceName = service.name
        ..price = service.price
        ..timestamp = DateTime.now();

      await _isarService.saveCutRecord(record);
      await fetchHistory(); // Reload and re-calculate the entire UI list
    } catch (e) {
      errorMessage = 'Failed to record service';
      debugPrint('Error in recordService: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  MonthHistory monthAt(int index) => _monthlyHistory[index];
}
