import 'package:cut_count/core/constants/app_sizes.dart';
import 'package:cut_count/core/widgets/app_ui/app_ui.dart';
import 'package:cut_count/core/widgets/auto_size_text/reusable_auto_size_text.dart';
import 'package:cut_count/core/widgets/custom_list_tile.dart';
import 'package:cut_count/features/history/providers/history_provider.dart';
import 'package:cut_count/routes/routing_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppUi(
      appBarTitle: const Text('History'),
      body: Consumer<HistoryProvider>(
        builder: (context, provider, child) {
          final isMonthly = provider.showMonthly;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableAutoSizeText(
                'Cut history',
                style: Theme.of(context).textTheme.headlineMedium,
                maxLines: 1,
              ),
              const SizedBox(height: AppSizes.md),
              ToggleButtons(
                isSelected: [!isMonthly, isMonthly],
                onPressed: (index) => provider.toggleView(index == 1),
                borderRadius: BorderRadius.circular(12),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Today'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Monthly'),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.lg),
              if (isMonthly)
                ...provider.monthlyHistory.asMap().entries.map(
                      (entry) {
                        final month = entry.value;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSizes.sm),
                          child: CustomListTile(
                            onTap: () {
                              context.pushNamed(
                                RouteNames.historyMonth,
                                extra: month,
                              );
                            },
                            leading: const Icon(Icons.calendar_month_outlined),
                            title: ReusableAutoSizeText(
                              month.monthLabel,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            subtitle: Text(
                              '${month.totalCuts} • ${month.totalAmount}',
                            ),
                            trailing: const Icon(Icons.chevron_right),
                          ),
                        );
                      },
                    )
              else
                ...provider.todayHistory.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSizes.sm),
                    child: CustomListTile(
                      leading: const Icon(Icons.today),
                      title: ReusableAutoSizeText(
                        item.title,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(item.time),
                      trailing: Text(item.amount),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

