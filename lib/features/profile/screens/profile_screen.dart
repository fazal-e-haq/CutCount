import 'package:cut_count/core/constants/app_sizes.dart';
import 'package:cut_count/core/widgets/app_ui/app_ui.dart';
import 'package:cut_count/core/widgets/auto_size_text/reusable_auto_size_text.dart';
import 'package:cut_count/core/widgets/custom_list_tile.dart';
import 'package:cut_count/routes/routing_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Provider imports – SettingsProvider owns the profile name/subtitle;
// HistoryProvider owns all-time stats and monthly trend data.
import '../../settings/providers/settings_provider.dart';
import '../../history/providers/history_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppUi(
      appBarTitle: const Text('Profile'),
      appBarActions: [
        IconButton(
          onPressed: () => context.pushNamed(RouteNames.settings),
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
      // Consumer2 listens to both providers so the UI rebuilds when
      // the user edits their name OR when history data changes.
      body: Consumer2<SettingsProvider, HistoryProvider>(
        builder: (context, settings, history, child) {
          // Build trend point lists from real monthly history data.
          // If there is no data yet we show a single zero-value point
          // so the chart widgets don't receive an empty list.
          final cutsTrend = history.monthlyTrendCuts.isNotEmpty
              ? history.monthlyTrendCuts
                  .map((e) => _TrendPoint(label: e.key, value: e.value))
                  .toList()
              : [const _TrendPoint(label: '-', value: 0)];

          final amountTrend = history.monthlyTrendAmount.isNotEmpty
              ? history.monthlyTrendAmount
                  .map((e) => _TrendPoint(label: e.key, value: e.value))
                  .toList()
              : [const _TrendPoint(label: '-', value: 0)];

          // Format the all-time numbers with thousands separators.
          final cutsFormatted =
              history.allTimeCutsCount.toString().replaceAllMapped(
                    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
                    (m) => '${m[1]},',
                  );
          final amountFormatted =
              history.allTimeAmountValue.toString().replaceAllMapped(
                    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
                    (m) => '${m[1]},',
                  );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Profile header ----------
              Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Theme.of(context).dividerColor.withValues(alpha: 0.15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.lg),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: AppSizes.lg),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableAutoSizeText(
                              settings.userName,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              settings.userSubtitle,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        tooltip: 'Edit profile',
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.surface,
                        ),
                        onPressed: () => _showEditProfileSheet(
                          context,
                          settings,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ---------- All-time stat cards ----------
              const SizedBox(height: AppSizes.xl),
              Row(
                children: [
                  Expanded(
                    child: _ProfileStatCard(
                      title: 'All Time Cuts',
                      value: cutsFormatted,
                      icon: Icons.content_cut,
                    ),
                  ),
                  const SizedBox(width: AppSizes.md),
                  Expanded(
                    child: _ProfileStatCard(
                      title: 'All Time Amount',
                      value: '${settings.currencySymbol} $amountFormatted',
                      icon: Icons.payments_rounded,
                    ),
                  ),
                ],
              ),

              // ---------- Cuts trend bar chart ----------
              const SizedBox(height: AppSizes.xl),
              _BarChartSection(
                sectionTitle: 'All time cuts',
                points: cutsTrend,
                barColor: Theme.of(context).colorScheme.primary,
                valueLabelBuilder: (value) => value.toString(),
                totalLabel: 'Total Cuts',
                totalValue: cutsFormatted,
              ),

              // ---------- Amount trend bar chart ----------
              const SizedBox(height: AppSizes.xl),
              _BarChartSection(
                sectionTitle: 'All time amount',
                points: amountTrend,
                barColor: Theme.of(context).colorScheme.secondary,
                valueLabelBuilder: (value) =>
                    '${settings.currencySymbol} $value',
                totalLabel: 'Total Amount',
                totalValue: '${settings.currencySymbol} $amountFormatted',
              ),

              // ---------- Quick actions ----------
              const SizedBox(height: AppSizes.xl),
              ReusableAutoSizeText(
                'Quick actions',
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 1,
              ),
              const SizedBox(height: AppSizes.md),
              Card(
                child: Column(
                  children: const [
                    CustomListTile(
                      leading: Icon(Icons.history_toggle_off),
                      title:
                          Text('Export detail history of specific month'),
                      subtitle:
                          Text('Download or share month-level records'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Bottom sheet that lets the user edit their profile name and subtitle.
  // Pre-fills the text fields with current values from SettingsProvider.
  // -----------------------------------------------------------------------
  void _showEditProfileSheet(
    BuildContext context,
    SettingsProvider settings,
  ) {
    final nameController = TextEditingController(text: settings.userName);
    final subtitleController =
        TextEditingController(text: settings.userSubtitle);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return Padding(
          // Shift content up when the keyboard appears.
          padding: EdgeInsets.only(
            left: AppSizes.lg,
            right: AppSizes.lg,
            top: AppSizes.xl,
            bottom:
                MediaQuery.of(sheetContext).viewInsets.bottom + AppSizes.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Edit Profile',
                style: Theme.of(sheetContext).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSizes.lg),
              // Name input field
              TextField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: AppSizes.md),
              // Subtitle / tagline input field
              TextField(
                controller: subtitleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Subtitle',
                  hintText: 'e.g. Barber shop owner',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
              ),
              const SizedBox(height: AppSizes.xl),
              // Save button persists changes via SettingsProvider.
              FilledButton(
                onPressed: () {
                  final newName = nameController.text.trim();
                  final newSubtitle = subtitleController.text.trim();

                  // Only update if the user actually typed something.
                  if (newName.isNotEmpty) {
                    settings.updateName(newName);
                  }
                  if (newSubtitle.isNotEmpty) {
                    settings.updateSubtitle(newSubtitle);
                  }

                  Navigator.pop(sheetContext);

                  // Show a brief confirmation so the user knows it saved.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}

// -------------------------------------------------------------------------
// Private helper classes used only inside this file.
// -------------------------------------------------------------------------

/// A single data point on the monthly bar chart.
class _TrendPoint {
  const _TrendPoint({required this.label, required this.value});

  final String label;
  final int value;
}

/// Compact stat card showing an icon, title, and formatted value.
class _ProfileStatCard extends StatelessWidget {
  const _ProfileStatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 6),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------------
// Bar chart section: title + bar chart card + total summary row.
// -------------------------------------------------------------------------

/// A complete section showing a heading, monthly bar chart card,
/// and a total summary row beneath.
class _BarChartSection extends StatelessWidget {
  const _BarChartSection({
    required this.sectionTitle,
    required this.points,
    required this.barColor,
    required this.valueLabelBuilder,
    required this.totalLabel,
    required this.totalValue,
  });

  final String sectionTitle;
  final List<_TrendPoint> points;
  final Color barColor;
  final String Function(int value) valueLabelBuilder;
  final String totalLabel;
  final String totalValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableAutoSizeText(
          sectionTitle,
          style: Theme.of(context).textTheme.headlineSmall,
          maxLines: 1,
        ),
        const SizedBox(height: AppSizes.md),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.lg),
            child: Column(
              children: [
                _MonthlyBarChart(
                  points: points,
                  barColor: barColor,
                  valueLabelBuilder: valueLabelBuilder,
                ),
                const SizedBox(height: AppSizes.md),
                const Divider(height: 1),
                const SizedBox(height: AppSizes.md),
                _TotalSummaryRow(
                  label: totalLabel,
                  value: totalValue,
                  color: barColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Horizontally scrollable bar chart with monthly bars.
class _MonthlyBarChart extends StatelessWidget {
  const _MonthlyBarChart({
    required this.points,
    required this.barColor,
    required this.valueLabelBuilder,
  });

  final List<_TrendPoint> points;
  final Color barColor;
  final String Function(int value) valueLabelBuilder;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty || (points.length == 1 && points[0].value == 0)) {
      return SizedBox(
        height: 140,
        child: Center(
          child: Text(
            'No data yet',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      );
    }

    final maxValue =
        points.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    const chartHeight = 140.0;
    const barColumnWidth = 64.0; // width per bar column

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        // If bars fit inside the card, spread them out; otherwise scroll
        final contentWidth =
            (points.length * barColumnWidth).clamp(availableWidth, double.infinity);

        return SizedBox(
          height: chartHeight + 40, // extra 40 for labels below bars
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: contentWidth > availableWidth
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: SizedBox(
              width: contentWidth,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: points.map((point) {
                  final barFraction =
                      maxValue > 0 ? point.value / maxValue : 0.0;
                  final barHeight = (barFraction * (chartHeight - 24))
                      .clamp(4.0, chartHeight - 24);

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Value label above bar
                          Text(
                            valueLabelBuilder(point.value),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          // The bar itself
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOutCubic,
                            height: barHeight,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(6),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  barColor,
                                  barColor.withValues(alpha: 0.7),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          // Month label below bar
                          Text(
                            point.label,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Row at the bottom of the chart card showing the total.
class _TotalSummaryRow extends StatelessWidget {
  const _TotalSummaryRow({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}

