import 'package:cut_count/core/constants/app_sizes.dart';
import 'package:cut_count/core/layout/layout_size.dart';
import 'package:cut_count/core/widgets/app_ui/app_ui.dart';
import 'package:cut_count/core/widgets/auto_size_text/reusable_auto_size_text.dart';
import 'package:cut_count/core/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../history/providers/history_provider.dart';
import '../../services/providers/services_provider.dart';
import '../../settings/providers/settings_provider.dart';
import '../widgets/dashboard_stat_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The dashboard keeps the most important data above the fold and avoids visual noise.
    return AppUi(
      appBarTitle: const Text('Dashboard'),
      slivers: [
        Consumer3<ServicesProvider, HistoryProvider, SettingsProvider>(
          builder: (context, services, history, settings, child) {
            // Support backward compatibility if subagent hasn't updated providers yet
            final bool isHistoryLoading = (history as dynamic).isLoading ?? false;
            final String? historyError = (history as dynamic).errorMessage;
            final bool isServicesLoading = (services as dynamic).isLoading ?? false;
            final String? servicesError = (services as dynamic).errorMessage;

            final recentCuts = history.todayHistory.take(5).toList();
            return SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableAutoSizeText(
                        'Today overview',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: AppSizes.md),
                      if (historyError != null || servicesError != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppSizes.md),
                          child: Text(
                            historyError ?? servicesError!,
                            style: TextStyle(color: Theme.of(context).colorScheme.error),
                          ),
                        ),
                      DashboardView(history: history, settings: settings),
                      const SizedBox(height: AppSizes.lg),
                      ReusableAutoSizeText(
                        'Services',
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 1,
                      ),
                      const SizedBox(height: AppSizes.sm),
                      CuttingServices(history: history, services: services, settings: settings),
                      const SizedBox(height: AppSizes.lg),
                      ReusableAutoSizeText(
                        'Recent cuts',
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 1,
                      ),
                      const SizedBox(height: AppSizes.sm),
                    ],
                  ),
                ),
                SliverList.builder(
                  itemCount: recentCuts.length,
                  itemBuilder: (context, index) {
                    final item = recentCuts[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSizes.sm),
                      child: CustomListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.12),
                          child: Icon(
                            Icons.content_cut,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        title: ReusableAutoSizeText(
                          item.title,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(item.time),
                        trailing: Text(
                          '${settings.currencySymbol} ${item.amount}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
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

class CuttingServices extends StatelessWidget {
  const CuttingServices({super.key, required this.services, required this.history, required this.settings});
  final ServicesProvider services;
  final HistoryProvider history;
  final SettingsProvider settings;
  @override
  Widget build(BuildContext context) {
    if (services.services.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
        child: Text(
          'No services added yet. Go to the Services tab to add your prices.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      );
    }

    return SizedBox(
      height: 130, // Slightly taller to prevent text scaling overflows
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: services.services.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSizes.sm),
        itemBuilder: (context, index) {
          final item = services.services[index];
          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () async {
              await history.recordService(item);
              if (context.mounted) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added ${item.name} for ${settings.currencySymbol} ${item.price.toInt()}'),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }
            },
            child: Container(
              width: 140, // Increased width for better layout
              padding: const EdgeInsets.all(AppSizes.md),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ignore: non_const_argument_for_const_parameter
                      Icon(IconData(item.iconCodePoint, fontFamily: 'MaterialIcons'), color: Theme.of(context).colorScheme.primary, size: 32),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 16,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableAutoSizeText(
                        item.name,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${settings.currencySymbol} ${item.price.toInt()}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key, required this.history, required this.settings});
  final HistoryProvider history;
  final SettingsProvider settings;

  @override
  Widget build(BuildContext context) {
    final avgPerCut = history.todayCutsCount == 0 
        ? 0 
        : (history.todayAmountValue / history.todayCutsCount).round();

    return Column(
      children: [
        // 1. Main Card for Today's Earnings
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSizes.xl),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today\'s Earnings',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.9),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: Theme.of(context).colorScheme.onPrimary),
                        const SizedBox(width: 4),
                        Text(
                          'Today',
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.md),
              Text(
                '${settings.currencySymbol} ${history.todayAmountValue}',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: AppSizes.lg),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.trending_up, color: Theme.of(context).colorScheme.onPrimary, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Keep up the great work!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.md),
        
        // 2. Row of 2 smaller cards
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: DashboardStatCard(
                  title: 'Today Cuts',
                  value: '${history.todayCutsCount}',
                  icon: Icons.cut,
                ),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: DashboardStatCard(
                  title: 'Avg. per Cut',
                  value: '${settings.currencySymbol} $avgPerCut',
                  icon: Icons.analytics_outlined,
                  iconColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
