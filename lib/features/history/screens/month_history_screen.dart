import 'package:cut_count/core/constants/app_sizes.dart';
import 'package:cut_count/core/widgets/app_ui/app_ui.dart';
import 'package:cut_count/core/widgets/auto_size_text/reusable_auto_size_text.dart';
import 'package:cut_count/core/widgets/custom_list_tile.dart';
import 'package:cut_count/features/history/providers/history_provider.dart';
import 'package:flutter/material.dart';

class MonthHistoryScreen extends StatelessWidget {
  const MonthHistoryScreen({super.key, required this.monthHistory});

  final MonthHistory monthHistory;

  @override
  Widget build(BuildContext context) {
    return AppUi(
      appBarTitle: Text(monthHistory.monthLabel),
      slivers: [
        SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableAutoSizeText(
                    'Day by day history',
                    style: Theme.of(context).textTheme.headlineMedium,
                    maxLines: 1,
                  ),
                  const SizedBox(height: AppSizes.md),
                  Text(
                    '${monthHistory.totalCuts} cuts • ${monthHistory.totalAmount}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppSizes.lg),
                ],
              ),
            ),
            SliverList.builder(
              itemCount: monthHistory.days.length,
              itemBuilder: (context, index) {
                final day = monthHistory.days[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.sm),
                  child: CustomListTile(
                    leading: const Icon(Icons.event_note),
                    title: Text(day.dayLabel),
                    subtitle: Text('${day.cutCount} cuts'),
                    trailing: Text('${day.totalAmount}'),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

