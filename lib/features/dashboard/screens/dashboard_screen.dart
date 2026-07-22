import 'package:cut_count/core/constants/app_sizes.dart';
import 'package:cut_count/core/widgets/app_ui/app_ui.dart';
import 'package:cut_count/core/widgets/auto_size_text/reusable_auto_size_text.dart';
import 'package:cut_count/core/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../history/providers/history_provider.dart';
import '../../services/providers/services_provider.dart';
import '../widgets/dashboard_stat_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The dashboard keeps the most important data above the fold and avoids visual noise.
    return AppUi(
      appBarTitle: const Text('Dashboard'),
      body: Consumer2<ServicesProvider, HistoryProvider>(
        builder: (context, services, history, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableAutoSizeText(
                'Today overview',
                maxLines: 1,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSizes.md),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: AppSizes.xs,
                mainAxisSpacing: AppSizes.xs,
                childAspectRatio: 1.18,
                children: [
                  DashboardStatCard(
                    title: 'Today Amount',
                    value: 'Rs. ${history.todayAmountValue}',
                    icon: Icons.payments_rounded,
                  ),
                  DashboardStatCard(
                    title: 'Today Cuts',
                    value: '${history.todayCutsCount}',
                    icon: Icons.cut,
                  ),
                  const DashboardStatCard(
                    title: 'Monthly Amount',
                    value: 'Rs. 128,500',
                    icon: Icons.account_balance_wallet_rounded,
                  ),
                  const DashboardStatCard(
                    title: 'Monthly Cuts',
                    value: '122',
                    icon: Icons.cut,
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.lg),
              ReusableAutoSizeText(
                'Services',
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 1,
              ),
              const SizedBox(height: AppSizes.sm),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: services.services.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: AppSizes.sm),
                  itemBuilder: (context, index) {
                    final item = services.services[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => history.recordService(item),
                      child: Container(
                        width: 132,
                        padding: const EdgeInsets.all(AppSizes.md),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              item.icon,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableAutoSizeText(
                                  item.name,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.price,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSizes.lg),
              ReusableAutoSizeText(
                'Recent cuts',
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 1,
              ),
              const SizedBox(height: AppSizes.sm),
              ...history.todayHistory.take(5).map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSizes.sm),
                      child: CustomListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary.withValues(
                                    alpha: 0.12,
                                  ),
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
                          item.amount,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
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
