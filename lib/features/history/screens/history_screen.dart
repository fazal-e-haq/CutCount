import 'package:cut_count/core/constants/app_sizes.dart';
import 'package:cut_count/core/widgets/app_ui/app_ui.dart';
import 'package:cut_count/core/widgets/auto_size_text/reusable_auto_size_text.dart';
import 'package:cut_count/core/widgets/custom_list_tile.dart';
import 'package:cut_count/features/history/providers/history_provider.dart';
import 'package:cut_count/routes/routing_name.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../settings/providers/settings_provider.dart';
import 'earnings_chart.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppUi(
      appBarTitle: const Text('History'),
      slivers: [
        Consumer2<HistoryProvider, SettingsProvider>(
          builder: (context, provider, settings, child) {
            final isMonthly = provider.showMonthly;
            final bool isHistoryLoading = provider.isLoading;
            final String? historyError = provider.errorMessage;

            return SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableAutoSizeText(
                        'Cut history',
                        style: Theme.of(context).textTheme.headlineMedium,
                        maxLines: 1,
                      ),
                      const SizedBox(height: AppSizes.md),
                      if (historyError != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppSizes.md),
                          child: Text(
                            historyError,
                            style: TextStyle(color: Theme.of(context).colorScheme.error),
                          ),
                        ),
                      if (isHistoryLoading)
                        const Padding(
                          padding: EdgeInsets.only(bottom: AppSizes.md),
                          child: LinearProgressIndicator(),
                        ),
                      EarningsChart(weeklyEarnings: provider.weeklyEarnings, currencySymbol: settings.currencySymbol),
                      const SizedBox(height: AppSizes.lg),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return ToggleButtons(
                            constraints: BoxConstraints.expand(
                              width: (constraints.maxWidth - 4) / 2,
                              height: 48,
                            ),
                            isSelected: [!isMonthly, isMonthly],
                            onPressed: (index) => provider.toggleView(index == 1),
                            borderRadius: BorderRadius.circular(12),
                            fillColor: Theme.of(context).colorScheme.primary,
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                'Today',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: !isMonthly
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                'Monthly',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: isMonthly
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: AppSizes.lg),
                    ],
                  ),
                ),
                if (isMonthly)
                  SliverList.builder(
                    itemCount: provider.monthlyHistory.length,
                    itemBuilder: (context, index) {
                      final month = provider.monthlyHistory[index];
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
                            '${month.totalCuts} cuts • ${settings.currencySymbol} ${month.totalAmount}',
                          ),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      );
                    },
                  )
                else
                  SliverList.builder(
                    itemCount: provider.todayHistory.length,
                    itemBuilder: (context, index) {
                      final item = provider.todayHistory[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSizes.sm),
                        child: CustomListTile(
                          leading: const Icon(Icons.today),
                          title: ReusableAutoSizeText(
                            item.title,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          subtitle: Text(DateFormat.jm().format(item.time)),
                          trailing: Text('${settings.currencySymbol} ${item.amount}'),
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
