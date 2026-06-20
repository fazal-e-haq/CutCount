import 'package:cut_count/core/widgets/app_ui.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppUi(topCard: TopCard( 
      padding: EdgeInsets.all(16),
      child: Text('data'),), children: []);
  }
}





















// import 'package:flutter/material.dart';
//
// import 'package:cut_count/core/widgets/app_ui.dart';
//
// class HistoryScreen extends StatefulWidget {
//   const HistoryScreen({super.key});
//
//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }
//
// class _HistoryScreenState extends State<HistoryScreen> {
//   bool _isDaily = true;
//
//   static const List<_HistoryEntry> _dailyEntries = [
//     _HistoryEntry('Fade', '11:42 AM', 'PKR 700', Color(0xFFE95401)),
//     _HistoryEntry('Beard trim', '10:58 AM', 'PKR 250', Color(0xFF00897B)),
//     _HistoryEntry('Classic cut', '10:21 AM', 'PKR 500', Color(0xFF3949AB)),
//     _HistoryEntry('Shave', '09:40 AM', 'PKR 150', Color(0xFF7B1FA2)),
//   ];
//
//   static const List<_MonthEntry> _monthEntries = [
//     _MonthEntry('June 2026', '286 cuts', 'PKR 168k', Color(0xFFE95401)),
//     _MonthEntry('May 2026', '241 cuts', 'PKR 143k', Color(0xFF00897B)),
//     _MonthEntry('April 2026', '219 cuts', 'PKR 129k', Color(0xFF3949AB)),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return AppPage(
//       title: 'History',
//       subtitle: 'Review daily details and monthly performance.',
//       trailing: SolidIconButton(
//         icon: Icons.ios_share_rounded,
//         tooltip: 'Export',
//         onPressed: () {},
//       ),
//       children: [
//         FadeSlideIn(
//           child: _PeriodSwitch(
//             isDaily: _isDaily,
//             onChanged: (value) {
//               setState(() {
//                 _isDaily = value;
//               });
//             },
//           ),
//         ),
//         const SizedBox(height: 18),
//         AnimatedSwitcher(
//           duration: const Duration(milliseconds: 300),
//           switchInCurve: Curves.easeOutCubic,
//           switchOutCurve: Curves.easeInCubic,
//           transitionBuilder: (child, animation) {
//             return FadeTransition(
//               opacity: animation,
//               child: SlideTransition(
//                 position: Tween<Offset>(
//                   begin: const Offset(0, 0.04),
//                   end: Offset.zero,
//                 ).animate(animation),
//                 child: child,
//               ),
//             );
//           },
//           child: _isDaily
//               ? _DailyHistory(
//                   key: const ValueKey('daily'),
//                   entries: _dailyEntries,
//                 )
//               : _MonthlyHistory(
//                   key: const ValueKey('monthly'),
//                   entries: _monthEntries,
//                 ),
//         ),
//       ],
//     );
//   }
// }
//
// class _PeriodSwitch extends StatelessWidget {
//   const _PeriodSwitch({required this.isDaily, required this.onChanged});
//
//   final bool isDaily;
//   final ValueChanged<bool> onChanged;
//
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final primary = colorScheme.primary;
//
//     return AppCard(
//       padding: const EdgeInsets.all(6),
//       child: Row(
//         children: [
//           Expanded(
//             child: _SegmentButton(
//               label: 'Daily',
//               icon: Icons.today_rounded,
//               selected: isDaily,
//               color: primary,
//               onTap: () => onChanged(true),
//             ),
//           ),
//           const SizedBox(width: 6),
//           Expanded(
//             child: _SegmentButton(
//               label: 'Monthly',
//               icon: Icons.calendar_month_rounded,
//               selected: !isDaily,
//               color: primary,
//               onTap: () => onChanged(false),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _SegmentButton extends StatelessWidget {
//   const _SegmentButton({
//     required this.label,
//     required this.icon,
//     required this.selected,
//     required this.color,
//     required this.onTap,
//   });
//
//   final String label;
//   final IconData icon;
//   final bool selected;
//   final Color color;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 220),
//       curve: Curves.easeOutCubic,
//       decoration: BoxDecoration(
//         color: selected ? color : Colors.transparent,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(8),
//         onTap: onTap,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 size: 18,
//                 color: selected ? Colors.white : colorScheme.onSurface,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 label,
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   color: selected ? Colors.white : colorScheme.onSurface,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _DailyHistory extends StatelessWidget {
//   const _DailyHistory({super.key, required this.entries});
//
//   final List<_HistoryEntry> entries;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           childAspectRatio: 1.28,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           children: const [
//             MetricCard(
//               label: 'Daily cuts',
//               value: '18',
//               icon: Icons.content_cut_rounded,
//               accent: Color(0xFFE95401),
//               footer: 'Today',
//             ),
//             MetricCard(
//               label: 'Daily earnings',
//               value: 'PKR 9.4k',
//               icon: Icons.payments_rounded,
//               accent: Color(0xFF00897B),
//               footer: 'Recorded',
//             ),
//           ],
//         ),
//         const SizedBox(height: 24),
//         const SectionHeader(title: 'Detailed daily view'),
//         ...entries.map(
//           (entry) => Padding(
//             padding: const EdgeInsets.only(bottom: 12),
//             child: AppListRow(
//               icon: Icons.content_cut_rounded,
//               title: entry.serviceName,
//               subtitle: entry.time,
//               accent: entry.color,
//               trailing: StatusPill(label: entry.amount, color: entry.color),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _MonthlyHistory extends StatelessWidget {
//   const _MonthlyHistory({super.key, required this.entries});
//
//   final List<_MonthEntry> entries;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           childAspectRatio: 1.28,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           children: const [
//             MetricCard(
//               label: 'Monthly cuts',
//               value: '286',
//               icon: Icons.calendar_month_rounded,
//               accent: Color(0xFF3949AB),
//               footer: 'June',
//             ),
//             MetricCard(
//               label: 'Monthly earnings',
//               value: 'PKR 168k',
//               icon: Icons.bar_chart_rounded,
//               accent: Color(0xFF7B1FA2),
//               footer: 'June',
//             ),
//           ],
//         ),
//         const SizedBox(height: 24),
//         const SectionHeader(title: 'Monthly view'),
//         ...entries.map(
//           (entry) => Padding(
//             padding: const EdgeInsets.only(bottom: 12),
//             child: AppListRow(
//               icon: Icons.event_note_rounded,
//               title: entry.month,
//               subtitle: entry.cuts,
//               accent: entry.color,
//               trailing: Text(
//                 entry.earnings,
//                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                   fontWeight: FontWeight.w800,
//                   color: Theme.of(context).colorScheme.onSurface,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _HistoryEntry {
//   const _HistoryEntry(this.serviceName, this.time, this.amount, this.color);
//
//   final String serviceName;
//   final String time;
//   final String amount;
//   final Color color;
// }
//
// class _MonthEntry {
//   const _MonthEntry(this.month, this.cuts, this.earnings, this.color);
//
//   final String month;
//   final String cuts;
//   final String earnings;
//   final Color color;
// }
