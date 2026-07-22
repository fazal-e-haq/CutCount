import 'package:flutter/material.dart';
import '../../services/providers/services_provider.dart';

// Holds today's cuts and month-level cut summaries for the history area.
// This structure mirrors a future backend response shape, so the UI can stay simple.
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
  bool showMonthly = true;

  int todayCutsCount = 3;
  int todayAmountValue = 1350;

  // Short list for today's activity so the app can show a quick glance view.
  final List<HistoryItem> _todayHistory = [
    HistoryItem(title: 'Fade Cut', amount: 'Rs. 800', time: '09:15 AM'),
    HistoryItem(title: 'Shave', amount: 'Rs. 300', time: '10:05 AM'),
    HistoryItem(title: 'Hair Wash', amount: 'Rs. 250', time: '11:20 AM'),
  ];

  List<HistoryItem> get todayHistory => List.unmodifiable(_todayHistory);

  // Month summaries are used by the monthly history screen and the month-detail page.
  final List<MonthHistory> monthlyHistory = [
    MonthHistory(
      monthLabel: 'July 2026',
      totalCuts: '128 cuts',
      totalAmount: 'Rs. 96,000',
      days: [
        HistoryItem(title: '01 Jul', amount: 'Rs. 4,200', time: '18 cuts'),
        HistoryItem(title: '02 Jul', amount: 'Rs. 5,100', time: '21 cuts'),
        HistoryItem(title: '03 Jul', amount: 'Rs. 3,600', time: '15 cuts'),
      ],
    ),
    MonthHistory(
      monthLabel: 'June 2026',
      totalCuts: '112 cuts',
      totalAmount: 'Rs. 84,500',
      days: [
        HistoryItem(title: '28 Jun', amount: 'Rs. 3,900', time: '16 cuts'),
        HistoryItem(title: '29 Jun', amount: 'Rs. 4,750', time: '20 cuts'),
      ],
    ),
  ];

  void toggleView(bool monthly) {
    showMonthly = monthly;
    notifyListeners();
  }

  // Adds a service selection to today's history and updates summary counters.
  void recordService(ServiceItem service) {
    final amount = _extractAmount(service.price);
    todayCutsCount += 1;
    todayAmountValue += amount;
    _todayHistory.insert(
      0,
      HistoryItem(
        title: service.name,
        amount: service.price,
        time: _currentTimeLabel(),
      ),
    );
    notifyListeners();
  }

  // Convenience helper for detail navigation.
  MonthHistory monthAt(int index) => monthlyHistory[index];

  int _extractAmount(String price) {
    final digits = price.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(digits) ?? 0;
  }

  String _currentTimeLabel() {
    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final suffix = now.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $suffix';
  }
}
