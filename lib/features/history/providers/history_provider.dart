import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/database/isar_service.dart';
import '../../../data/models/cut_record_model.dart';
import '../../../data/models/service_model.dart';

// ---------------------------------------------------------------------------
// UI models – hold raw data types so the UI layer owns all formatting.
// ---------------------------------------------------------------------------

/// A single history entry. Stores raw types; the UI formats them.
class HistoryItem {
  HistoryItem({
    required this.title,
    required this.amount,
    required this.time,
  });

  final String title;
  /// Raw integer amount (the UI adds currency symbols).
  final int amount;
  /// Timestamp of the cut – the UI calls DateFormat on it.
  final DateTime time;
}

/// Grouped history for one calendar month.
class MonthHistory {
  MonthHistory({
    required this.monthLabel,
    required this.totalCuts,
    required this.totalAmount,
    required this.days,
  });

  final String monthLabel;
  final int totalCuts;
  final int totalAmount;
  final List<DayHistory> days;
}

/// Grouped history for one day inside a month.
class DayHistory {
  DayHistory({
    required this.dayLabel,
    required this.cutCount,
    required this.totalAmount,
  });

  final String dayLabel;
  final int cutCount;
  final int totalAmount;
}

// ---------------------------------------------------------------------------
// HistoryProvider – uses targeted Isar queries for O(log N) performance
// instead of loading every record into memory.
// ---------------------------------------------------------------------------

class HistoryProvider with ChangeNotifier {
  final IsarService _isarService;

  bool isLoading = false;
  String? errorMessage;
  bool showMonthly = true;

  // --- Today stats (dashboard) ---
  int todayCutsCount = 0;
  int todayAmountValue = 0;
  List<HistoryItem> _todayHistory = [];

  // --- Current month stats ---
  int currentMonthCutsCount = 0;
  int currentMonthAmountValue = 0;

  // --- All-time stats (profile) ---
  int allTimeCutsCount = 0;
  int allTimeAmountValue = 0;

  // --- Monthly trend data for profile bar charts ---
  List<MapEntry<String, int>> monthlyTrendCuts = [];
  List<MapEntry<String, int>> monthlyTrendAmount = [];

  // --- Weekly earnings for history chart ---
  List<MapEntry<String, double>> _weeklyEarnings = [];

  // --- Monthly history groups for history screen ---
  List<MonthHistory> _monthlyHistory = [];

  HistoryProvider(this._isarService) {
    _init();
  }

  Future<void> _init() async {
    await _isarService.db;
    await fetchHistory();
  }

  // ---------------------------------------------------------------------------
  // Primary refresh – runs targeted queries in parallel for each data slice.
  // No single query loads the entire database.
  // ---------------------------------------------------------------------------
  Future<void> fetchHistory() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final now = DateTime.now();

      // Date boundaries – computed once, reused across queries.
      final startOfToday = DateTime(now.year, now.month, now.day);
      final endOfToday = startOfToday
          .add(const Duration(days: 1))
          .subtract(const Duration(microseconds: 1));

      final startOfMonth = DateTime(now.year, now.month);
      final endOfMonth = DateTime(now.year, now.month + 1)
          .subtract(const Duration(microseconds: 1));

      // Run independent queries in parallel for maximum speed.
      final results = await Future.wait([
        _fetchTodayData(startOfToday, endOfToday),       // [0]
        _fetchCurrentMonthStats(startOfMonth, endOfMonth), // [1]
        _fetchAllTimeStats(),                              // [2]
        _fetchWeeklyEarnings(now),                         // [3]
        _fetchMonthlyTrends(),                             // [4]
        _fetchMonthlyHistory(),                            // [5]
      ]);

      // Unpack results from the parallel futures.
      final todayData = results[0] as _TodayData;
      todayCutsCount = todayData.count;
      todayAmountValue = todayData.amount;
      _todayHistory = todayData.items;

      final monthStats = results[1] as _SimpleStats;
      currentMonthCutsCount = monthStats.count;
      currentMonthAmountValue = monthStats.amount;

      final allTime = results[2] as _SimpleStats;
      allTimeCutsCount = allTime.count;
      allTimeAmountValue = allTime.amount;

      _weeklyEarnings = results[3] as List<MapEntry<String, double>>;

      final trends = results[4] as _MonthlyTrends;
      monthlyTrendCuts = trends.cuts;
      monthlyTrendAmount = trends.amounts;

      _monthlyHistory = results[5] as List<MonthHistory>;
    } catch (e) {
      errorMessage = 'Failed to load history';
      debugPrint('Error in fetchHistory: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ---------------------------------------------------------------------------
  // Focused query methods – each touches only the records it needs.
  // ---------------------------------------------------------------------------

  /// Today's detailed records for the dashboard recent-cuts list.
  Future<_TodayData> _fetchTodayData(DateTime start, DateTime end) async {
    final records = await _isarService.getRecordsBetween(start, end);
    final items = records
        .map((r) => HistoryItem(
              title: r.serviceName,
              amount: r.price.toInt(),
              time: r.timestamp,
            ))
        .toList();
    final count = records.length;
    final amount = records.fold<int>(0, (sum, r) => sum + r.price.toInt());
    return _TodayData(count: count, amount: amount, items: items);
  }

  /// Aggregate count + sum for a date range (no objects loaded if possible).
  Future<_SimpleStats> _fetchCurrentMonthStats(
      DateTime start, DateTime end) async {
    final count = await _isarService.countRecordsBetween(start, end);
    final amount = await _isarService.sumPriceBetween(start, end);
    return _SimpleStats(count: count, amount: amount.toInt());
  }

  /// All-time aggregates – uses count + sum, never loads full objects.
  Future<_SimpleStats> _fetchAllTimeStats() async {
    final count = await _isarService.countAllRecords();
    final amount = await _isarService.sumAllPrices();
    return _SimpleStats(count: count, amount: amount.toInt());
  }

  /// Last 7 days earnings for the history bar chart.
  Future<List<MapEntry<String, double>>> _fetchWeeklyEarnings(
      DateTime now) async {
    final List<MapEntry<String, double>> earnings = [];
    for (int i = 6; i >= 0; i--) {
      final day = DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: i));
      final nextDay = day.add(const Duration(days: 1))
          .subtract(const Duration(microseconds: 1));
      final dayTotal = await _isarService.sumPriceBetween(day, nextDay);
      earnings.add(MapEntry(DateFormat('EEE').format(day), dayTotal));
    }
    return earnings;
  }

  /// Monthly trend data for the profile bar charts.
  /// Walks month-by-month from the earliest record to now.
  Future<_MonthlyTrends> _fetchMonthlyTrends() async {
    final earliest = await _isarService.getEarliestRecordDate();
    if (earliest == null) {
      return _MonthlyTrends(cuts: [], amounts: []);
    }

    final now = DateTime.now();
    final List<MapEntry<String, int>> cuts = [];
    final List<MapEntry<String, int>> amounts = [];

    // Walk month-by-month from the earliest record's month to the current month.
    var cursor = DateTime(earliest.year, earliest.month);
    final endMonth = DateTime(now.year, now.month + 1);

    while (cursor.isBefore(endMonth)) {
      final monthEnd = DateTime(cursor.year, cursor.month + 1)
          .subtract(const Duration(microseconds: 1));
      final count = await _isarService.countRecordsBetween(cursor, monthEnd);
      final sum = await _isarService.sumPriceBetween(cursor, monthEnd);

      // Only include months that have data.
      if (count > 0) {
        final label = DateFormat('MMM yy').format(cursor);
        cuts.add(MapEntry(label, count));
        amounts.add(MapEntry(label, sum.toInt()));
      }

      // Advance to the next month.
      cursor = DateTime(cursor.year, cursor.month + 1);
    }

    return _MonthlyTrends(cuts: cuts, amounts: amounts);
  }

  /// Full monthly history with day-level grouping for the history screen.
  /// This is the only method that still loads records, but ONLY the ones
  /// needed for display (scoped per month).
  Future<List<MonthHistory>> _fetchMonthlyHistory() async {
    final earliest = await _isarService.getEarliestRecordDate();
    if (earliest == null) return [];

    final now = DateTime.now();
    final List<MonthHistory> months = [];

    // Walk month-by-month, newest first (for display order).
    var cursor = DateTime(now.year, now.month);
    final firstMonth = DateTime(earliest.year, earliest.month);

    while (!cursor.isBefore(firstMonth)) {
      final monthEnd = DateTime(cursor.year, cursor.month + 1)
          .subtract(const Duration(microseconds: 1));
      final records = await _isarService.getRecordsBetween(cursor, monthEnd);

      if (records.isNotEmpty) {
        // Group records by day inside this month.
        final Map<String, List<CutRecordModel>> dayGroups = {};
        int totalAmount = 0;
        for (final r in records) {
          totalAmount += r.price.toInt();
          final dayLabel = DateFormat('dd MMM').format(r.timestamp);
          (dayGroups[dayLabel] ??= []).add(r);
        }

        final days = dayGroups.entries.map((e) {
          final dayAmount =
              e.value.fold<double>(0, (sum, r) => sum + r.price).toInt();
          return DayHistory(
            dayLabel: e.key,
            cutCount: e.value.length,
            totalAmount: dayAmount,
          );
        }).toList();

        months.add(MonthHistory(
          monthLabel: DateFormat('MMMM yyyy').format(cursor),
          totalCuts: records.length,
          totalAmount: totalAmount,
          days: days,
        ));
      }

      // Move to the previous month.
      cursor = DateTime(cursor.year, cursor.month - 1);
    }

    return months;
  }

  // ---------------------------------------------------------------------------
  // Public getters
  // ---------------------------------------------------------------------------

  List<HistoryItem> get todayHistory => List.unmodifiable(_todayHistory);
  List<MonthHistory> get monthlyHistory => List.unmodifiable(_monthlyHistory);
  List<MapEntry<String, double>> get weeklyEarnings =>
      List.unmodifiable(_weeklyEarnings);

  void toggleView(bool monthly) {
    showMonthly = monthly;
    notifyListeners();
  }

  /// Record a new cut when a service is tapped on the dashboard.
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
      await fetchHistory();
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

// ---------------------------------------------------------------------------
// Private data classes used to shuttle results from Future.wait().
// ---------------------------------------------------------------------------

class _TodayData {
  const _TodayData({
    required this.count,
    required this.amount,
    required this.items,
  });
  final int count;
  final int amount;
  final List<HistoryItem> items;
}

class _SimpleStats {
  const _SimpleStats({required this.count, required this.amount});
  final int count;
  final int amount;
}

class _MonthlyTrends {
  const _MonthlyTrends({required this.cuts, required this.amounts});
  final List<MapEntry<String, int>> cuts;
  final List<MapEntry<String, int>> amounts;
}
